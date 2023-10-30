# frozen_string_literal: true

module ApplicationHelper
  include Pagy::Frontend

  def translate_enum(options)
    options.map {|key, value| [key.titleize, value]}
  end
end
