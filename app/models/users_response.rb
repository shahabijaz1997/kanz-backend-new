# frozen_string_literal: true

class UsersResponse < ApplicationRecord
  belongs_to :question
  belongs_to :user
end
