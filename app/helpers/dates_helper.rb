module DatesHelper
  DATE_WITH_TIME_AND_ZONE = '%b %d, %Y %H:%M:%S (%Z)'.freeze
  DATE_WITHOUT_TIME_AND_ZONE = '%b %d, %Y %H:%M:%S'.freeze
  DEFAULT_DISPLAY_TIME_ZONE = 'CET'

  class << self
    def standard_format(date)
      date.strftime(DATE_WITHOUT_TIME_AND_ZONE)
    end

    def zoned_format(date, time_zone: DEFAULT_DISPLAY_TIME_ZONE)
      date.in_time_zone(time_zone).strftime(DATE_WITH_TIME_AND_ZONE)
    end
  end
end
