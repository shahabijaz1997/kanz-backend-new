# module ActiveAdmin

class InvestorPolicy < ApplicationPolicy
   
    class Scope < Struct.new(:user, :scope)
      def resolve
        scope
      end
    end

    def index?
      user.customer_support_rep? || user.compliance_officer? # Only allow admin users to access the index page
    end

    def show?
      user.customer_support_rep? || user.compliance_officer?# Only allow admin users to view individual admin users
    end

    def create?
      false 
    end

    def update?
      false
    end

    def destroy?
      false
    end

  end
# end