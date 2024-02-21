module Informer
  extend ActiveSupport::Concern

  included do
    def inform_deal_creator
      DealsMailer::status_changed(@deal).deliver_now
    end
  end
end
