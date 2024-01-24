# frozen_string_literal: true

module ApprovalHelper
  def user_can_approve(resource)
    (current_admin_user.customer_support_rep? && resource.submitted?) ||
      (current_admin_user.compliance_officer? && resource.verified?)
  end

  def info_message(status)
    if current_admin_user.customer_support_rep? && status.eql?('verified')
      'Application has been verified'
    elsif current_admin_user.compliance_officer? && status.eql?('submitted')
      'Approval pending from the Customer Support Rep.'
    elsif %w[reopened rejected submitted approved].include?(status)
      "Application has been #{status}"
    elsif status.eql?('closed')
      "Application has already been #{status}"
    else
      'Application is in progress'
    end
  end

  def approval_options(resource)
    if current_admin_user.customer_support_rep? && resource.submitted?
      [['Request Change', :reopened], ['Verify', :verified, {:checked => true}]]
    elsif current_admin_user.compliance_officer? && verified_syndicate_deal?(resource)
      [['Request Change', :reopened], ['Approve', :approved, {:checked => true}]]
    elsif current_admin_user.compliance_officer? && verified_classic_deal?(resource)
      [['Request Change', :reopened], ['Approve', :live, {:checked => true}]]
    elsif current_admin_user.compliance_officer? && resource.verified?
      [['Reject', :rejected], ['Approve', :approved, {:checked => true}]]
    end
  end

  def user_info(user)
    if user.is_a?(AdminUser)
      "#{user.fullname} (#{user.admin_role.title})"
    else
      "#{user.name} (#{user.type.titleize})"
    end
  end

  def customer_support_rep_attachments(resource)
    resource.attachments.where(uploaded_by: AdminUser.customer_support_rep)
  end
  
  def compliance_officer_attachments(resource)
    resource.attachments.where(uploaded_by: AdminUser.compliance_officer)
  end

  def verified_syndicate_deal?(resource)
    resource.is_a?(Deal) && resource.verified? && resource.syndicate?
  end

  def verified_classic_deal?(resource)
    resource.is_a?(Deal) && resource.verified? && resource.classic?
  end

  def can_close_deal?(resource)
    current_admin_user.customer_support_rep? || current_admin_user.compliance_officer?
  end
end
