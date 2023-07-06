# module ActiveAdmin

  class AdminUserPolicy < ApplicationPolicy
   
    class Scope < Scope
      def resolve
        user_context.admin? ? scope.customer_users : scope.all
      end
    end

    def index?
      user_context.admin? || user_context.super_admin? # Only allow admin users to access the index page
    end

    def show?
      user_context.admin? || user_context.super_admin? # Only allow admin users to view individual admin users
    end

    def create?
      user_context.admin? || user_context.super_admin? # Only allow admin users to create new admin users
    end

    def update?
      user_context.admin? || user_context.super_admin? # Only allow admin users to update admin users
    end

    def destroy?
      user_context.admin? || user_context.super_admin? # Only allow admin users to delete admin users
    end

  end
# end