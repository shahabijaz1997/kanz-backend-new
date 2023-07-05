# module ActiveAdmin

class UserPolicy < ApplicationPolicy
   
    class Scope < Struct.new(:user, :scope)
      def resolve
        scope
      end
    end

    def index?
      user.customer_support_rep? || user.compliance_officer? # Only allow admin users to access the index page
    end

    def show?
      user.customer_support_rep? || user.compliance_officer? # Only allow admin users to access the index page
    end

    def create?
      false # Only allow admin users to create new admin users
    end

    def update?
      false # Only allow admin users to update admin users
    end

    def destroy?
      false # Only allow admin users to delete admin users
    end

  end
# end