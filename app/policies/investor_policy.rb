# frozen_string_literal: true

class InvestorPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def individuals?
    user_context.customer_support_rep? || user_context.compliance_officer?
  end

  def firms?
    individuals?
  end

  def show?
    individuals?
  end

  def update?
    individuals?
  end
end
