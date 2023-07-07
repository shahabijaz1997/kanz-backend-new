class Option < ApplicationRecord
  belongs_to :question
  validates :statement, :index, presence: true
end
