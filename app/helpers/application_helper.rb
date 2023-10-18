# frozen_string_literal: true

module ApplicationHelper
  include Pagy::Frontend

  def option_value(id)
    Option.find_by(id: id)&.statement
  end
end
