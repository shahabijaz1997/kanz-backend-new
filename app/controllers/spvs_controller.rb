class SpvsController < ApplicationController
  before_action :setup_step, only: %i[back new create update]
  before_action :find_deal, only: %i[new]
  before_action :find_spv, only: %i[show update back edit]

  def index
    @pagy, @spvs = pagy Spv.all 
  end

  def new
    @spv = @deal.spv || Spv.new(deal_id: @deal.id, closing_model: params[:closing_model])
    @spv.step = params[:step]
    render turbo_stream: turbo_stream.append('spv-modal', partial: 'spv/new')
  end

  def create
    @spv = current_user.spvs.new(spv_params)
    Spv.transaction do
      @spv.save!
      @spv.deal.update!(closing_model: @spv.closing_model, status: 'closed')
      next_step
    end
    render turbo_stream: turbo_stream.update('stepper', partial: "spv/modal_body")
  rescue StandardError => e
    @errors = [e.message]
    render turbo_stream: turbo_stream.update('stepper', partial: "spv/modal_body")
  end

  def edit
    @step = SPV_FIRST_STEP
    render turbo_stream: turbo_stream.append('spv-modal', partial: 'spv/new')
  end

  def update
    next_step if @spv.update(spv_params)
    @errors = @spv.errors.full_messages
    respond_to do |format|
      format.html { redirect_to spvs_path }
      format.turbo_stream { render turbo_stream: turbo_stream.update('stepper', partial: "spv/modal_body") }
    end
  end

  def back
    previous_step
    render turbo_stream: turbo_stream.update('stepper', partial: "spv/modal_body")
  end

  private

  def find_deal
    @deal = Deal.find_by(id: params[:deal_id])
  end

  def find_spv
    @spv = Spv.find_by(id: params[:id]) || Spv.find_by(id: params[:spv_id])
  end

  def setup_step
    return @step = 1 if params[:step].blank?
    params[:step] = params[:step].to_i
    @step = steps_in_range? ? params[:step] : 1
  end

  def spv_params
    params.require(:spv).permit(
      :step,
      :legal_name,
      :date_of_incorporation,
      :place_of_incorporation,
      :registration_certificate,
      :legal_structure,
      :jurisdiction,
      :registered_office_address,
      :directors,
      :governance_structure,
      :management_agreements,
      :parent_company,
      :investment_nature,
      :investment_strategy,
      :capital_raised,
      :investment_thresholds,
      :valuation_report,
      :terms,
      :aml_kyc_document,
      :dfsa_compliance_regulations,
      :risk_disclosures,
      :data_protection_compliance,
      :bank_name,
      :branch_name,
      :account_no,
      :account_title,
      :capital_requirements,
      :audited_financial_statements,
      :financial_projections,
      :financial_reporting,
      :investor_reporting,
      :performance_metrics,
      :shareholder_agreements,
      :property_deeds,
      :loan_agreement,
      :service_provider_contracts,
      :business_plan,
      :service_providers,
      :insurance_policies,
      :exit_options,
      :divestment_process,
      :communication_channels,
      :investor_queries,
      :deal_id,
      :closing_model
    )
  end

  def next_step
    @completed = @step == SPV_LAST_STEP
    @step += 1 if @step < SPV_LAST_STEP
  end

  def previous_step
    @step -= 1 if @step > SPV_FIRST_STEP
  end

  def steps_in_range?
    params[:step] >= SPV_FIRST_STEP && params[:step] <= SPV_LAST_STEP
  end
end
