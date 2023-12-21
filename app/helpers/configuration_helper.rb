# frozen_string_literal: true

module ConfigurationHelper
  def user_can_update?
    current_admin_user.super_admin?
  end
end
