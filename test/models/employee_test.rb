require "test_helper"

describe Employee do
  # it "does a thing" do
  #   value(1+1).must_equal 2
  # end

  # Relationships
  should belong_to(:user)

  # Validations
  should validate_presence_of(:ssn)
  should validate_uniqueness_of(:ssn).case_insensitive
  should allow_value("123456789").for(:ssn)
  should_not allow_value("12345678").for(:ssn)

  setup do
    create_employee_users
    create_employees
  end

  teardown do
    destroy_employees
  end

   # Test the before_validation callback that sanitizes the SSN.
   should "sanitize_ssn callback removes non-digit characters" do
    employee = FactoryBot.build(:employee, ssn: "123-45-6789")
    employee.valid?  # triggers callbacks
    assert_equal "123456789", employee.ssn, "SSN should be sanitized to remove non-digit characters"
  end

  # # Test custom validation for date_hired.
  # should "date_hired cannot be in the future" do
  #   employee = FactoryBot.build(:employee, date_hired: Date.tomorrow)
  #   assert_not employee.valid?, "Employee with a future date_hired should be invalid"
  #   assert_includes employee.errors[:date_hired], "cannot be in the future"
  # end

  # should "date_hired is valid when blank" do
  #   employee = FactoryBot.build(:employee, date_hired: nil)
  #   assert employee.valid?, "Employee should be valid if date_hired is blank"
  # end

  # # Test custom validation for date_terminated.
  # should "date_terminated must be after date_hired" do
  #   employee = FactoryBot.build(:employee, date_hired: Date.today, date_terminated: Date.today - 1)
  #   assert_not employee.valid?, "Employee with date_terminated before date_hired should be invalid"
  #   assert_includes employee.errors[:date_terminated], "must be after the date hired"
  # end

  # should "date_terminated cannot be in the future" do
  #   employee = FactoryBot.build(:employee, date_terminated: Date.tomorrow)
  #   assert_not employee.valid?, "Employee with a future date_terminated should be invalid"
  #   assert_includes employee.errors[:date_terminated], "cannot be in the future"
  # end

  # should "date_terminated is valid when blank" do
  #   employee = FactoryBot.build(:employee, date_terminated: nil)
  #   assert employee.valid?, "Employee should be valid if date_terminated is blank"
  # end

  should "active scope returns only active employees" do
    Employee.active.each do |employee|
      assert employee.active, "Employee #{employee.first_name} should be active"
    end
  end

  should "inactive scope returns only inactive employees" do
    Employee.inactive.each do |employee|
      assert_not employee.active, "Employee #{employee.first_name}} should be inactive"
    end
  end

  should "alphabetical scope orders by last name then first name" do
      employees = Employee.alphabetical
      sorted_employees = employees.sort_by { |e| [e.last_name, e.first_name] }
      assert_equal sorted_employees.map(&:id), employees.map(&:id), "Employees should be ordered alphabetically by last and first name"
  end

  # should "after_save callback deactivates associated user when employee becomes inactive" do
  #   employee = FactoryBot.create(:employee, active: true)
  #   user = employee.user
  #   assert user.active, "Associated user should initially be active"
  #   employee.update(active: false)
  #   user.reload
  #   assert_not user.active, "User should be deactivated when employee is deactivated"
  # end
end
