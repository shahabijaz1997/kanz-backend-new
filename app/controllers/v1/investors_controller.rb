# frozen_string_literal: true

# Investor persona
module V1
  class InvestorsController < ApiController
    before_action :validate_persona, except: %i[index show]
    before_action :search_params, only: %i[deals index]
    before_action :find_investor, only: %i[show]

    def index
      pagy, investors = pagy Investor.approved.ransack(params[:search]).result
      investors = InvestorSerializer.new(investors).serializable_hash[:data].map
      success('success', 
        {
          records: investors,
          pagy: pagy
        }
      )
    end

    def show
      investor_attributes = InvestorSerializer.new(@investor).serializable_hash[:data][:attributes]
      success(I18n.t('investor.get.success.show'), investor_attributes)
    end

    def investor_type
      UsersResponse.transaction do
        if @investor.role_id != role.id
          @investor.update!(role_id: role.id)
          Investors::SwitchRole.call(@investor)
        else
          update_state
        end
      end
      success(I18n.t('investor.update.success.role', kind: investor_params[:role]))
    rescue StandardError => error
      failure(error.message)
    end

    def accreditation
      profile = @investor.profile || InvestorProfile.new(investor_id: @investor.id)

      if profile.update(accreditation_params)
        success(I18n.t('investor.update.success.accreditation'))
      else
        failure(profile.errors.full_messages.to_sentence)
      end
    end

    def deals
      @deals = Deal.live_or_closed.ransack(params[:search]).result
      @deals = @deals.user_invested(current_user.id) if params[:invested].present?
      stats = stats_by_deal_type
      params[:deal_type] ||= [Deal::deal_types.values]
      pagy, @deals = pagy @deals.where(deal_type: params[:deal_type]).latest_first

      success(
        'success',
        { deals: DealSerializer.new(@deals).serializable_hash[:data].map do |d|
            if d[:attributes][:details].present?
              d[:attributes].merge!(d[:attributes][:details])
              d[:attributes].delete(:details)
            end
            d[:attributes][:invested_amount] = current_user.investments_in_deal(d[:attributes][:id])
            d[:attributes]
          end
        }.merge(stats: stats, pagy: pagy)
      )
    end

    def show
      syndicate_member = current_user.syndicate_members.build(member_id: @investor.id)
      success(
        'success',
        SyndicateMemberSerializer.new(syndicate_member).serializable_hash[:data][:attributes]
      )
    end

    private

    def validate_persona
      unprocessable unless current_user.investor?

      @investor = current_user
    end

    def accreditation_params
      params.require(:investor_profile).permit(%i[legal_name country_id accreditation_option_id
                                                  residence_id accepted_investment_criteria])
    end

    def investor_params
      params.require(:investor).permit(:role)
    end

    def role
      Role.find_by(title: investor_params[:role])
    end

    def update_state
      profile_states = @investor.profile_states
      profile_states[:investor_type] = @investor.role_title
      @investor.update(profile_states: profile_states)
    end

    def find_investor
      @investor = Investor.approved.find_by(id: params[:id])
      failure(I18n.t('investor.not_found')) if @investor.blank?
    end

    def stats_by_deal_type
      {
        all: @deals.count,
        property: @deals.property.count,
        startup: @deals.startup.count
      }
    end
  end
end
