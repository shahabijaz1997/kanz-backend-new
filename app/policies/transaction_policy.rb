# frozen_string_literal: true

class TransactionPolicy < ApplicationPolicy
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
end
