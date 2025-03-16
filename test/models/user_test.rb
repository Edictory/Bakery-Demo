require "test_helper"

describe User do
  # it "does a thing" do
  #   value(1+1).must_equal 2
  # end
  should have_one(:employee)
  should have_one(:customer)

  should have_secure_password

  setup do
    create_customer_users
    create_employee_users
  end

  teardown do
    destroy_customer_users
  end

  should "allow user to authenticate with password" do
    assert @u_ryan.authenticate("secret")
    deny @u_ryan.authenticate(":3")
  end

  should "active scope returns only active users" do
    active_users = User.active
    active_users.each do |user|
      assert user.active, "User #{user.username} should be active"
    end
  end

  should "inactive scope returns only inactive users" do
    inactive_users = User.inactive
    inactive_users.each do |user|
      assert_not user.active, "User #{user.username} should be inactive"
    end
  end

  should "employees scope returns only non-customer users" do
    employees = User.employees
    employees.each do |user|
      refute_equal "customer", user.role, "User #{user.username} should not be a customer"
    end
  end

  should "alphabetical scope returns users ordered by username" do
    usernames = User.alphabetical.map(&:username)
    sorted_usernames = usernames.sort
    assert_equal sorted_usernames, usernames, "Usernames should be in alphabetical order"
  end

  should "customer_role scope returns only customer users" do
    customers = User.customer_role
    customers.each do |user|
      assert_equal "customer", user.role, "User #{user.username} should have customer role"
    end
  end

  should "manager_role scope returns only manager users" do
    managers = User.manager_role
    managers.each do |user|
      assert_equal "manager", user.role, "User #{user.username} should have manager role"
    end
  end

  should "baker_role scope returns only baker users" do
    bakers = User.baker_role
    bakers.each do |user|
      assert_equal "baker", user.role, "User #{user.username} should have baker role"
    end
  end

  should "shipper_role scope returns only shipper users" do
    shippers = User.shipper_role
    shippers.each do |user|
      assert_equal "shipper", user.role, "User #{user.username} should have shipper role"
    end
  end

  should "have class method to handle authentication services" do
    assert User.authenticate('alexe', 'secret')
    deny User.authenticate('alexe', '>:D')
  end
end
