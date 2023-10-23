module UserOnboarding
  extend ActiveSupport::Concern

  included do
    def inform_applicant
      OnboardingMailer::status_changed(self).deliver_now
    end
  end
end