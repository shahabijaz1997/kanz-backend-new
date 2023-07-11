# module ActiveAdmin

class InvestorPolicy < ApplicationPolicy

  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    user_context.customer_support_rep? || user_context.compliance_officer? # Only allow customer users to access the index page
  end

  def show?
    index?
  end

  def update?
    index?
  end
end