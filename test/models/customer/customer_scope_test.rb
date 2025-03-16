require 'test_helper'

class CustomerScopeTest < ActiveSupport::TestCase
  context "Within context" do
    setup do
      create_customer_users
      create_customers
    end

    should "show that scope exists for alphabeticizing customers" do
      assert_equal ["Chen", "Corletti", "Egan", "Flood", "Freeman"], Customer.alphabetical.all.map(&:last_name)
    end

    should "show that there are four active customers" do
      assert_equal ["Corletti", "Egan", "Flood", "Freeman"], Customer.active.all.map(&:last_name).sort
    end

    should "show that there is one inactive customer" do
      assert_equal ["Chen"], Customer.inactive.all.map(&:last_name).sort
    end
  end
end