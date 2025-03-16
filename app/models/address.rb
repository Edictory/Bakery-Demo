class Address < ApplicationRecord
  # get modules to help with some functionality
  include Validations
  include Deletions
  include Activeable::InstanceMethods
  extend Activeable::ClassMethods

  # Relationships
  has_many :orders
  belongs_to :customer

  # Scopes
  scope :by_recipient,  -> { order(:recipient) }
  scope :by_customer,   -> { joins(:customer).order('customers.last_name').order('customers.first_name') }
  scope :shipping,      -> { where(is_billing: false) }
  scope :billing,       -> { where(is_billing: true) }

  # Validations
  validates_presence_of :street_1, :recipient, :zip
  validates_format_of :zip, with: /\A\d{5}\z/, message: "should be five digits long"
  validates_inclusion_of :state, in: ['PA','WV'], message: "is not a state we service at this time", allow_blank: false
  validate :address_is_not_a_duplicate, on: :create
  validate :there_is_one_billing_address
  validate -> { is_active_in_system(:customer) }

  def already_exists?
    Address.where(customer_id: self.customer_id, recipient: self.recipient, zip: self.zip).size == 1
  end

  # Callbacks
  before_save :reset_prior_billing_address

  # Other methods
  private
  def address_is_not_a_duplicate
    return true if self.customer_id.nil? || self.recipient.nil? || self.zip.nil?
    if self.already_exists?
      errors.add(:recipient, "already exists for this recipient at this zip code")
    end
  end

  def there_is_one_billing_address
    return true if self.is_billing && self.active
    return true if self.street_1.nil? || self.recipient.nil? || self.zip.nil?
    other_addresses = self.customer.addresses.active.billing - [self]
    if other_addresses.empty?
      errors.add(:base, "There must be an active billing address on file.")
    end
  end

  def reset_prior_billing_address
    return true unless self.is_billing
    prior_billing_address = self.customer.addresses.active.billing.first
    return true if prior_billing_address.nil?  # no prior billing address to reset
    prior_billing_address.update_attribute(:is_billing, false)
  end
end