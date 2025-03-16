class Customer < ApplicationRecord
  # get modules to help with some functionality
  include Validations
  include Deletions
  include Activeable::InstanceMethods
  extend Activeable::ClassMethods

  # Relationships
  has_many :orders
  has_many :addresses
  belongs_to :user

  # Scopes
  scope :alphabetical,  -> { order(:last_name).order(:first_name) }

  # Validations
  validates_presence_of :last_name, :first_name, :email
  validates_format_of :phone, with: /\A(\d{10}|\(?\d{3}\)?[-. ]\d{3}[-.]\d{4})\z/, message: "should be 10 digits (area code needed) and delimited with dashes only", allow_blank: true
  validates_format_of :email, with: /\A[\w]([^@\s,;]+)@(([\w-]+\.)+(com|edu|org|net|gov|mil|biz|info))\z/i, message: "is not a valid format"


  # Callbacks
  before_save -> { strip_nondigits_from(:phone) }


  # Other methods
  def name
    "#{last_name}, #{first_name}"
  end

  def proper_name
    "#{first_name} #{last_name}"
  end

  def billing_address
    self.addresses.active.billing.first
  end

end
