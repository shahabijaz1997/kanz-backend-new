# frozen_string_literal: true

class SyndicateProfile < ApplicationRecord
  belongs_to :syndicate
  has_one :attachment, as: :parent, dependent: :destroy

  after_update :update_user_status

  def self.ransackable_attributes(auth_object = nil)
    %w[region industry_market]
  end

  private

  def update_user_status
    syndicate.update(status: User.statuses[:submitted])
  end
end
