class DropPropertyOwnerProfile < ActiveRecord::Migration[7.0]
  def change
    sql = "Select * from property_owner_profiles"
    profiles_array = ActiveRecord::Base.connection.execute(sql)
    profiles_array.each do |profile|
      fund_raiser_profile = FundRaiserProfile.new(
        residence_id: profile['residence_id'],
        nationality_id: profile['residence_id'],
        no_of_properties: profile['no_of_properties'],
        fund_raiser_id: profile['property_owner_id']
      )
      unless fund_raiser_profile.save(validate: false)
        Rails.logger.error(fund_raiser_profile.errors.full_messages.to_sentence)
        raise StandardError, fund_raiser_profile.errors.full_messages.to_sentence
      end
    end

    drop_table :property_owner_profiles
  end
end
