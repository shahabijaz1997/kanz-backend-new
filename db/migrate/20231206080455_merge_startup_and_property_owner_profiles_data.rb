class MergeStartupAndPropertyOwnerProfilesData < ActiveRecord::Migration[7.0]
  def change
    FundRaiser.all.each do |fund_raiser|
      next if fund_raiser.profile.blank?
      fund_raiser.profile.update_attribute(:nationality_id, fund_raiser.profile.residence_id)
    end
  end
end
