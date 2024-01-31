class Blog < ApplicationRecord
  belongs_to :author, class_name: "AdminUser"
  belongs_to :approved_by, class_name: "AdminUser", optional: true

  enum status: %i[draft completed published archived]

  validates :title, :content, presence: true

  def self.ransackable_attributes(_auth_object = nil)
    %w[id title status created_at updated_at]
  end

  def self.ransackable_associations(auth_object = nil)
    ["approved_by", "author"]
  end
end
