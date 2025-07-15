class Prompt < ApplicationRecord
  has_paper_trail
  validates :content, presence: true

  private

  def self.ransackable_associations(auth_object = nil)
    ["versions"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["content", "created_at", "id", "updated_at"]
  end
end