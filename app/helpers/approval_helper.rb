# frozen_string_literal: true

module ApprovalHelper
  def user_can_approve(status)
    (current_admin_user.customer_support_rep? && status.eql?('submitted')) ||
      (current_admin_user.compliance_officer? && status.eql?('verified'))
  end

  def info_message(status)
    if current_admin_user.customer_support_rep? && status.eql?('verified')
      'Application has been verified'
    elsif current_admin_user.compliance_officer? && status.eql?('submitted')
      'Approval pending from the Customer Support Rep.'
    elsif %w[reopened rejected submitted approved].include?(status)
      "Application has been #{status}"
    else
      'Application is in progress'
    end
  end

  def user_info(user)
    "#{user.fullname} (#{user.admin_role.title})"
  end
end
