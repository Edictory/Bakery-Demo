class OrderItem < ApplicationRecord
  include Validations
  include Deletions
  include Activeable::InstanceMethods
  include Activeable::ClassMethods

  belongs_to :order
  belongs_to :item

  
  # Scopes
  scope :shipped, -> { where.not(shipped_on: nil) }
  scope :unshipped, -> { where(shipped_on: nil) }

  # Validations
  validates :quantity, presence: true, numericality: { greater_than: 0 }
  validates_date :shipped_on, allow_blank: true
end