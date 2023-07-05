# module ActiveAdmin

  class AdminUserPolicy < ApplicationPolicy
   
    class Scope < Struct.new(:user, :scope)
      def resolve
        scope
      end
    end

    def index?
      user.admin? || user.super_admin? # Only allow admin users to access the index page
    end

    def show?
      user.admin? || user.super_admin? # Only allow admin users to view individual admin users
    end

    def create?
      user.admin? || user.super_admin? # Only allow admin users to create new admin users
    end

    def update?
      user.super_admin? # Only allow admin users to update admin users
    end

    def destroy?
      user.super_admin? # Only allow admin users to delete admin users
    end

  end
# end