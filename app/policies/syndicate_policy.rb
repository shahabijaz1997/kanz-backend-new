# frozen_string_literal: true

class SyndicatePolicy < ApplicationPolicy
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

  def all?
    user_context.investor?
  end
end
