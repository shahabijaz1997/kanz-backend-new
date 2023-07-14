# frozen_string_literal: true

class AdminUserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      user_context.admin? ? scope.customer_users : scope.all
    end
  end

  def index?
    user_context.admin? || user_context.super_admin?
  end

  def show?
    index?
  end

  def create?
    index?
  end

  def update?
    index?
  end

  def destroy?
    index?
  end

  def reactivate?
    index?
  end
end
