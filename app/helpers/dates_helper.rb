# frozen_string_literal: true

module DatesHelper
  DATE_ONLY = '%b %d, %Y'
  DATE_WITH_TIME_AND_ZONE = '%b %d, %Y %H:%M:%S (%Z)'
  DATE_WITHOUT_TIME_AND_ZONE = '%b %d, %Y %I:%M %p'
  DEFAULT_DISPLAY_TIME_ZONE = 'Asia/Muscat'

  class << self
    def standard_format(date, time_zone: DEFAULT_DISPLAY_TIME_ZONE)
      return nil if date.blank?

      date.in_time_zone(time_zone).strftime(DATE_WITHOUT_TIME_AND_ZONE)
    end

    def zoned_format(date, time_zone: DEFAULT_DISPLAY_TIME_ZONE)
      return nil if date.blank?

      date.in_time_zone(time_zone).strftime(DATE_WITH_TIME_AND_ZONE)
    end

    def date_only(date, time_zone: DEFAULT_DISPLAY_TIME_ZONE)
      return nil if date.blank?

      date.in_time_zone(time_zone).strftime(DATE_ONLY)
    end
  end
end
