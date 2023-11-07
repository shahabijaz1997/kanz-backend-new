# frozen_string_literal: true

class PropertyOwnerPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    # Only allow customer users to access the index page
    user_context.customer_support_rep? || user_context.compliance_officer?
  end

  def show?
    index?
  end

  def update?
    index?
  end
end
