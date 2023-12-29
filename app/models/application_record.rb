# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  def humanized_enum(enum_value)
    I18n.t("enums.#{model_name.i18n_key}.#{enum_value}")
  end
end
