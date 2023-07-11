module ApprovalHelper
  def user_can_approve(status)
    if current_admin_user.customer_support_rep? && status.eql?('submitted')
      return true
    elsif current_admin_user.compliance_officer? && status.eql?('verified')
      return true
    else
      return false
    end
  end

  def info_message(status)
    if current_admin_user.customer_support_rep? && status.eql?('verified')
      return "Application has been verified"
    elsif current_admin_user.compliance_officer? && status.eql?('submitted')
      return "Approval pending from the Customer Support Rep."
    elsif status.eql?('reopened')
      return "Application is reopened for changes"
    elsif status.eql?('rejected')
      return "Application has been rejected"
    elsif status.eql?('approved')
      return "Application has been approved"
    elsif status.eql?('submitted')
      return "Application has been submitted"
    else    
      return "Application is in progress"
    end
  end
  
  def user_info(user)
    (user.fullname)+" ("+user.admin_role.title+")"
  end
end