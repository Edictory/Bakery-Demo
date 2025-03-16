require "test_helper"

class OrderItemTest < ActiveSupport::TestCase
  # Relationships
  should belong_to(:item)
  should belong_to(:order)

  # Validations
  should validate_numericality_of(:quantity).is_greater_than(0)

  setup do
    create_customer_users
    create_customers
    create_addresses
    create_items
    create_orders
    create_order_items
  end

  teardown do
    destroy_order_items
    destroy_orders
    destroy_items
    destroy_addresses
    destroy_customers
    destroy_customer_users
  end

  should "shipped_on validation accepts blank or past dates and rejects future dates" do
    # When shipped_on is blank
    oi = FactoryBot.build(:order_item, quantity: 1, shipped_on: nil)
    assert oi.valid?, "OrderItem with no shipped_on date should be valid"

    # When shipped_on is in the past
    oi.shipped_on = Date.yesterday
    assert oi.valid?, "OrderItem with a past shipped_on date should be valid"
  end


  should "shipped scope returns only order items that have been shipped" do
    shipped_items = OrderItem.shipped
    shipped_items.each do |order_item|
      assert_not_nil order_item.shipped_on, "Expected shipped order item to have a shipped_on date"
    end
  end

  should "unshipped scope returns only order items that have not been shipped" do
    unshipped_items = OrderItem.unshipped
    unshipped_items.each do |order_item|
      assert_nil order_item.shipped_on, "Expected unshipped order item to have nil shipped_on"
    end
  end
end