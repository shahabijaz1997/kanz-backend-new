# frozen_string_literal: true

class SyndicateProfile < ApplicationRecord
  belongs_to :syndicate
  has_many :attachments, as: :parent, dependent: :destroy

  after_update :update_user_status

  private

  def update_user_status
    syndicate.update(status: User.statuses[:submitted])
  end
end
