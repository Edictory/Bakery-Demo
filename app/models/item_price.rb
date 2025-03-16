class ItemPrice < ApplicationRecord
  belongs_to :item

  # Validations
  validates :price, numericality: { greater_than_or_equal_to: 0 }

  # Scopes
  scope :current, -> { where(end_date: nil)}
  scope :for_date, ->(date) { where("start_date <= ? AND (end_date > ? OR end_date IS NULL)", date, date) }
  scope :for_item, ->(item_id) { where(item_id: item_id) }
  scope :chronological, -> { order(start_date: :desc) }
end
