class Order < ApplicationRecord
  # get module to help with some functionality
  require 'base64'
  include Validations
  include Deletions

  # Relationships
  belongs_to :customer
  belongs_to :address
  has_many :order_items
  has_many :items, through: :order_items


  # Scopes
  scope :chronological, -> { order(date: :desc) }
  scope :paid,          -> { where.not(payment_receipt: nil) }
  scope :for_customer,  ->(customer_id) { where(customer_id: customer_id) }

  # Validations
  validates_date :date
  validates_numericality_of :grand_total, greater_than_or_equal_to: 0
  validate -> { is_active_in_system(:customer) }
  validate -> { is_active_in_system(:address) }

  # Callbacks
  before_create :set_order_date

  # Methods
  def pay
    return false unless self.payment_receipt.nil?
    generate_payment_receipt
    self.save!
    self.payment_receipt
  end

  private
  def generate_payment_receipt 
    self.payment_receipt = Base64.encode64("order: #{self.id}; amount_paid: #{self.grand_total}; received: #{self.date}; billing_zip: #{self.customer.billing_address.zip}")
  end

  def set_order_date
    self.date = Date.current
  end
end