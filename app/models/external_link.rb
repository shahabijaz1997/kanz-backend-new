class ExternalLink < ApplicationRecord
  belongs_to :deal, optional: true
end
