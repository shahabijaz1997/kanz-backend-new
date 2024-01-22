class SpvsController < ApplicationController
  before_action :setup_step, only: %i[new create update]
  before_action :find_deal, only: %i[new]
  before_action :find_spv, only: %i[show update]

  def index
    @pagy, @spvs = pagy Spv.all
  end

  def new
    @spv = Spv.new(deal_id: @deal.id, closing_model: params[:closing_model], step: params[:step])
    render turbo_stream: turbo_stream.append('spv-modal', partial: 'spv/new')
  end

  def create
    @spv = current_user.spvs.new(spv_params)
    if @spv.save
      next_step
    else
      @errors = @spv.errors.full_messages
    end
    render turbo_stream: turbo_stream.update('stepper', partial: "spv/modal_body")
  end

  def update
    if @spv.update(spv_params)
      next_step
    else
      @errors = @spv.errors.full_messages
    end
    render turbo_stream: turbo_stream.update('stepper', partial: "spv/modal_body")
  end

  private

  def spv_params
    params.require(:spv).permit(
      :step,
      :legal_name,
      :date_of_incorporation,
      :place_of_incorporation,
      :registration_certificate_id,
      :legal_structure,
      :jurisdiction,
      :registered_office_address,
      :directors,
      :governance_structure_id,
      :management_agreements,
      :parent_company,
      :investment_nature,
      :investment_strategy_id,
      :capital_raised,
      :investment_thresholds,
      :valuation_report_id,
      :terms,
      :aml_kyc_document_id,
      :dfsa_compliance_regulations_id,
      :risk_disclosures,
      :data_protection_compliance_id,
      :bank_name,
      :branch_name,
      :account_no,
      :account_title,
      :capital_requirements,
      :audited_financial_statements_id,
      :financial_projections_id,
      :financial_reporting_id,
      :investor_reporting_id,
      :performance_metrics_id,
      :shareholder_agreements_id,
      :property_deeds_id,
      :loan_agreement_id,
      :service_provider_contracts_id,
      :business_plan_id,
      :service_providers_id,
      :insurance_policies_id,
      :exit_options,
      :divestment_process_id,
      :communication_channels_id,
      :investor_queries,
      :deal_id,
      :closing_model
    )
  end

  def find_deal
    @deal = Deal.find_by(id: params[:deal_id])
  end

  def find_spv
    @spv = Spv.find_by(id: params[:id])
  end

  def setup_step
    return @step = 1 if params[:step].blank?
    params[:step] = params[:step].to_i
    @step = steps_in_range? ? params[:step] : 1
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
