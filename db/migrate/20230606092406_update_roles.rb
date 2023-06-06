class UpdateRoles < ActiveRecord::Migration[7.0]
  def change
    roles = ['Individual Investor','Investment Firm', 'Syndicate', 'Realtor', 'Startup']
    
    User.where(role_id: nil).each do |user|
      role_id = Role.find_by(title: roles[user.role.to_i]).id
      user.update(role_id: role_id)
    end
  end
end
