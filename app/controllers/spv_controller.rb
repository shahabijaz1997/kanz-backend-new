class SpvController < ApplicationController
  def index
    @pagy, @spvs = pagy Spv.all
  end

  def create
    @spv = current_user.spvs.new(spv_params)    
    return redirect_to spvs_path, notice: 'SPV created successfuly!' if @spv.save

    respond_to do |format|
      format.json { render json {errors: @spv.errors.full_messages }.to_json }
    end
  end

  private

  def spv_params
    params.permit(:spv).require(
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
      :investor_queries
    )
  end
end
