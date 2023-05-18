# frozen_string_literal: true

require 'ostruct'

class ApplicationService
  def self.call(...)
    new(...).call
  end

  def response(message: '', status: true, data: {}, code: 200)
    OpenStruct.new(
      message:,
      status:,
      data:,
      code:
    )
  end
end
