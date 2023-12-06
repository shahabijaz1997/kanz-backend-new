class UpdatePropertyOwnerAndStartupType < ActiveRecord::Migration[7.0]
  def change
    if User.exists?(type: ['Startup', 'PropertyOwner'])
      User.where(type: ['Startup', 'PropertyOwner']).update_all(type: 'FundRaiser')
    end
  end
end
