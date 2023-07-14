class Industry < ApplicationRecord
  has_many :profiles_industries, dependent: :destroy
end
