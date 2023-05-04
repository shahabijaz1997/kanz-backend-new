# frozen_string_literal: true

# Fix for no session store found with devise-jwt
module RackSessionSolution
  extend ActiveSupport::Concern
  # Fake sessions as no need to use cookies for jwt
  class FakeRackSession < Hash
    def enabled?
      false
    end
  end
  included do
    before_action :set_fake_rack_session_for_devise

    private

    def set_fake_rack_session_for_devise
      request.env['rack.session'] ||= FakeRackSession.new
    end
  end
end
