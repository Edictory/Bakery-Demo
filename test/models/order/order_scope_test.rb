require 'test_helper'

class OrderScopeTest < ActiveSupport::TestCase
  context "Within context" do
    setup do 
      create_customer_users
      create_customers
      create_addresses
      create_orders
    end

    should "have a working scope called paid" do
      assert_equal [5.25, 5.50, 16.50], Order.paid.all.map(&:grand_total).sort
    end

    # should "have a working scope called chronological" do
    #   assert_equal [22.50,5.50,16.50,11, 5.25, 5.50, 5.25], Order.chronological.all.map(&:grand_total)
    # end

    should "have a working scope called chronological" do
      orders = Order.chronological.all
      orders.each_cons(2) do |earlier, later|
        assert earlier.date >= later.date, "Order #{earlier.id} (#{earlier.date}) should come before Order #{later.id} (#{later.date})"
      end
    end
    
    should "have a working scope called for_customer" do
      assert_equal [5.25, 5.25, 22.50], Order.for_customer(@alexe).all.map(&:grand_total).sort
    end

  end
end

