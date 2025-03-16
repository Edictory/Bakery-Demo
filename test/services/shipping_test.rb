require 'test_helper'

class ShippingTest < ActiveSupport::TestCase
  # see README.md for more information on the Shipping service
  
  # given the defaults of 5 pounds allowed, $2.00 as the base charge, 
  # and an incremental charge of $0.25 per extra pound... 

  should "return nil if the weight set is somehow set to nil" do
    assert_nil Shipping.calculate_shipping_costs(nil)
  end

  should "only charge the base rate for an order weight at or under the allowed amount" do
    assert_equal 2.00, Shipping.calculate_shipping_costs(5)
    assert_equal 2.00, Shipping.calculate_shipping_costs(4)
  end

  should "add an incremental charge for every pound over the allowed weight" do
    assert_equal 2.00, Shipping.calculate_shipping_costs(5)
    assert_equal 2.25, Shipping.calculate_shipping_costs(6)
    assert_equal 2.50, Shipping.calculate_shipping_costs(7)
    assert_equal 2.75, Shipping.calculate_shipping_costs(8)
    assert_equal 3.00, Shipping.calculate_shipping_costs(9)
    assert_equal 3.25, Shipping.calculate_shipping_costs(10)
  end

  should "truncate down and not charge for fractions of a pound" do
    assert_equal 2.00, Shipping.calculate_shipping_costs(5, allowed=5)
    assert_equal 2.00, Shipping.calculate_shipping_costs(5.5, allowed=5)
    assert_equal 2.25, Shipping.calculate_shipping_costs(6, allowed=5)
    assert_equal 2.25, Shipping.calculate_shipping_costs(6.7, allowed=5)
    assert_equal 2.25, Shipping.calculate_shipping_costs(6.95, allowed=5)
    assert_equal 2.50, Shipping.calculate_shipping_costs(7, allowed=5)
    assert_equal 2.50, Shipping.calculate_shipping_costs(7.05, allowed=5)
  end

  should "raise costs if the allowed weight drops" do
    assert_equal 2.00, Shipping.calculate_shipping_costs(4)
    assert_equal 2.25, Shipping.calculate_shipping_costs(4, allowed=3)
  end

  should "raise costs if the base rate goes up" do
    assert_equal 2.00, Shipping.calculate_shipping_costs(4, allowed=5, base_rate=2.0)
    assert_equal 3.50, Shipping.calculate_shipping_costs(4, allowed=5, base_rate=3.5)
  end

  should "raise costs if the increment weight goes up" do
    assert_equal 3.25, Shipping.calculate_shipping_costs(10, allowed=5, base_rate=2.0)
    assert_equal 4.50, Shipping.calculate_shipping_costs(10, allowed=5, base_rate=2.0, increment_rate=0.5)
  end

  should "raise costs if both the base rate and increment weight goes up" do
    assert_equal 3.25, Shipping.calculate_shipping_costs(10, allowed=5, base_rate=2.0)
    assert_equal 4.75, Shipping.calculate_shipping_costs(10, allowed=5, base_rate=3.5)
    assert_equal 6.00, Shipping.calculate_shipping_costs(10, allowed=5, base_rate=3.5, increment_rate=0.5)
  end

end