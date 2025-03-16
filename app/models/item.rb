class Item < ApplicationRecord
  # Relationships
  has_many :item_prices
  has_many :order_items
  has_many :orders, through: :order_items

  enum :category, { breads: 1, muffins: 2, pastries: 3 }, scopes: false, default: :breads
  CATEGORIES = [
    ["Breads", Item.categories[:breads]],
    ["Muffins", Item.categories[:muffins]],
    ["Pastries", Item.categories[:pastries]]
  ]

  # Scopes
  scope :active,       -> { where(active: true) }
  scope :inactive,     -> { where(active: false) }
  scope :alphabetical, -> { order('LOWER(name)') }
  scope :breads,       -> { where(category: categories[:breads]) }
  scope :muffins,      -> { where(category: categories[:muffins]) }
  scope :pastries,     -> { where(category: categories[:pastries]) }

  # Validations
  validates :name, presence: true,
                uniqueness: { case_sensitive: false }
  validates :weight, numericality: { greater_than: 0 }
  validates :units_per_item, numericality: { only_integer: true, greater_than: 0 }
end
