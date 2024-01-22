# frozen_string_literal: true

class InvestorPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    user_context.customer_support_rep? || user_context.compliance_officer? || user_context.syndicate? || user_context.creator?
  end

  def show?
    user_context.customer_support_rep? || user_context.compliance_officer?
  end

  def update?
    user_context.customer_support_rep? || user_context.compliance_officer?
  end

  def destroy?
    user_context.customer_support_rep? || user_context.compliance_officer?
  end

  def reactivate?
    user_context.customer_support_rep? || user_context.compliance_officer?
  end
end
