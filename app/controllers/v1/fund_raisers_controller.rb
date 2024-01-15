# frozen_string_literal: true

# Fund Raiser's apis
module V1
  class FundRaisersController < ApiController
    before_action :validate_fund_raiser
    before_action :check_file_presence, only: %i[create]
    before_action :search_params, only: %i[investors]

    def show
      fund_raiser_attributes = FundRaiserSerializer.new(@fund_raiser).serializable_hash[:data][:attributes]
      success(I18n.t('fund_raiser.get.success.show'), fund_raiser_attributes)
    end

    def create
      profile = @fund_raiser.profile || FundRaiserProfile.new(fund_raiser_id: @fund_raiser.id)
      FundRaiserProfile.transaction do
        profile.update!(profile_params.except(:logo))
        Attachment.upload_file(profile, profile_params[:logo]) if profile_params[:logo].present?
      end
      success(I18n.t('fund_raiser.update.success.comapny_info'))
    rescue StandardError => e
      failure(profile.errors.full_messages.to_sentence.presence || e.message)
    end

    def investors
      investments = Investment.joins(:deal, :user).where(deal: {user_id: current_user.id})
      pagy, investments = pagy investments.ransack(params[:search]).result.distinct

      success(
        'success',
        {
          records: InvestmentListSerializer.new(investments).serializable_hash[:data].map { |d| d[:attributes] },
          stats: {},
          pagy: pagy
        }
      )
    end

    private

    def profile_params
      return [] unless params[:fund_raiser_profile][:step].to_i.in?([1,2])

      if params[:fund_raiser_profile][:step].to_i == 1
        params.require(:fund_raiser_profile).permit(
          :step, :company_name, :legal_name, :residence_id, :nationality_id, :website, :address, industry_ids: []
        )
      else
        params.require(:fund_raiser_profile).permit(
          :step, :logo, :description, :ceo_name, :ceo_email, :total_capital_raised,
          :current_round_capital_target, :currency
        )
      end
    end

    def validate_fund_raiser
      return unprocessable unless current_user.fund_raiser?

      @fund_raiser = current_user
    end

    def check_file_presence
      return if @fund_raiser.profile&.attachment || params[:fund_raiser_profile][:step].to_i == 1

      failure(I18n.t('errors.exceptions.file_missing')) if profile_params[:logo].blank?
    end
  end
end
