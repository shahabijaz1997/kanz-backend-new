# frozen_string_literal: true

module StatusHelper
  class << self
    def colorized_status(status)
      return if status.nil?

      case status
      when :submitted then 'primary'
      when :approved then 'success'
      when :rejected then 'danger'
      when :verified then 'info'
      when :reopened then 'warning'
      else 'secondary'
      end
    end
  end
end
