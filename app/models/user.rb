class User < ApplicationRecord

  has_secure_password

  has_one :employee
  has_one :customer

  enum :role, { customer: 1, baker: 2, shipper: 3, manager: 4}, scopes: true, default: :customer, suffix: true
  ROLES = [
    ['Customer', User.roles[:customer]],
    ['Baker', User.roles[:baker]],
    ['Shipper', User.roles[:shipper]],
    ['Manager', User.roles[:manager]]
  ]

  # Scopes
  scope :active, -> { where(active: true) }
  scope :inactive, -> { where(active: false) }
  scope :employees, -> { where.not(role: roles[:customer]) }
  scope :alphabetical, -> { order(:username) }
  # scope :customer_role, -> { where(role: roles[:customer]) }
  # scope :manager_role, -> { where(role: roles[:manager]) }
  # scope :baker_role, -> { where(role: roles[:baker]) }
  # scope :shipper_role, -> { where(role: roles[:shipper]) }

  # validates_presence_of :password, :on => :create 
  # validates_presence_of :password_confirmation, :on => :create 
  # validates_confirmation_of :password, message: "Does not match"
  # validates_length_of :password, minimum: 4, message: "Password must be at least 4 characters long", allow_blank: true
  # validates_inclusion_of :role, in: %w( customer baker shipper manager ), message: "Role not recognized in the system"

  def self.authenticate(username, password)
    find_by_username(username).try(:authenticate, password)
  end
end
