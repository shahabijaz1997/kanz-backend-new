# frozen_string_literal: true

class DealPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    user_context.customer_support_rep? || user_context.compliance_officer?
  end

  def show?
    index?
  end

  def update?
    index?
  end

  def extend?
    index?
  end

  def close?
    index?
  end

  def valuation_update?
    index?
  end
end
