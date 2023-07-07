module DateHelper
  DATE_WITH_TIME_AND_ZONE = '%b %d, %Y %H:%M (%Z)'.freeze
  DEFAULT_DISPLAY_TIME_ZONE = 'CET'

  class << self
    def humanize_game_date_time(date)
      date.to_s(:long).sub('00:00', '').strip
    end

    def standard_format(date)
      date.strftime('%b %d %H:%M')
    end

    def standard_date_format(date)
      date.strftime('%b %d, %Y')
    end

    def zoned_format(date:, time_zone: DEFAULT_DISPLAY_TIME_ZONE)
      date.in_time_zone(time_zone).strftime(DATE_WITH_TIME_AND_ZONE)
    end
  end
end
