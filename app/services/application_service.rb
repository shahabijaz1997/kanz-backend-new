# frozen_string_literal: true

class ApplicationService
  def self.call(...)
    new(...).call
  end

  def response(message = '', status = true, data = {}, code = 200)
    Struct.new(:message, :status, :data, :code).new(
      message, status, data, code
    )
  end
end
