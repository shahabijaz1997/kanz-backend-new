# frozen_string_literal: true

# Fast json serializer
class InvestorProfileSerializer
  include JSONAPI::Serializer

  attributes :id

  attribute :en do |profile|
    {
      legal_name: profile.legal_name,
      nationality: profile.country&.name,
      location: profile.country&.name,
      residence: profile.residence&.name,
      accreditation: accreditation_en(profile),
      accepted_investment_criteria: profile.accepted_investment_criteria
    }.except(*keys_to_remove(profile.investor))
  end

  attribute :ar do |profile|
    {
      legal_name: profile.legal_name,
      nationality: profile.country&.name_ar,
      location: profile.country&.name_ar,
      residence: profile.residence&.name_ar,
      accreditation: accreditation_ar(profile),
      accepted_investment_criteria: profile.accepted_investment_criteria
    }.except(*keys_to_remove(profile.investor))
  end

  private

  class << self
    def keys_to_remove(investor)
      investor.individual_investor? ? [:legal_name, :location] : [:nationality, :residence]
    end

    def question(profile)
      investor = profile.investor
      individual = investor.individual_investor?
      question = individual ? Question.individual_accredition : Question.firm_accredition
    end

    def accreditation_ar(profile)
      question = question(profile)
      selected_option = profile.accreditation_option&.id

      {
        question_statement: question.statement_ar,
        options: question.options.map { |o| {
          id: o.id, statement: o.statement_ar, selected: o.id == selected_option
        } },
      }
    end

    def accreditation_en(profile)
      question = question(profile)
      selected_option = profile.accreditation_option&.id

      {
        question_statement: question.statement,
        options: question.options.map { |o| {
          id: o.id, statement: o.statement, selected: o.id == selected_option
        } },
      }
    end
  end
end
