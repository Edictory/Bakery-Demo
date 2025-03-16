class Employee < ApplicationRecord
  belongs_to :user

  # Scopes
  scope :active, -> { where(active: true) }
  scope :inactive, -> { where(active: false) }
  scope :alphabetical, -> { order(:last_name, :first_name) }
  
  # Callback to remove non-digit characters from SSN before validation
  before_validation :sanitize_ssn

  # Validations
  validates :ssn, presence: true,
                  uniqueness: true,
                  format: { with: /\A\d{9}\z/, message: "must be 9 digits (dashes and spaces are allowed)" }
  
  # validate :date_hired_cannot_be_in_the_future
  # validate :date_terminated_validations



  # # Callback to update the associated user when an employee is deactivated
  # after_save :deactivate_user_if_employee_inactive

  private

  def sanitize_ssn
    self.ssn = ssn.to_s.gsub(/\D/, "") if ssn.present?
  end

  # def date_hired_cannot_be_in_the_future
  #   return if date_hired.blank?
  #   if date_hired > Date.today
  #     errors.add(:date_hired, "cannot be in the future")
  #   end
  # end

  # def date_terminated_validations
  #   return if date_terminated.blank?
    
  #   # Ensure date_terminated is after date_hired if date_hired is provided
  #   if date_hired.present? && date_terminated <= date_hired
  #     errors.add(:date_terminated, "must be after the date hired")
  #   end

  #   # Ensure date_terminated is today or in the past
  #   if date_terminated > Date.today
  #     errors.add(:date_terminated, "cannot be in the future")
  #   end
  # end

  # def deactivate_user_if_employee_inactive
  #   if saved_change_to_active? && active == false
  #     # Automatically deactivate the associated user
  #     user.update(active: false)
  #   end
  # end
end