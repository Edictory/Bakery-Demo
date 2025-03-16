require 'test_helper'

class BakingTest < ActiveSupport::TestCase
  context "Within context" do
    setup do 
      create_breads
      create_bread_prices
      create_customer_users
      create_customers
      create_addresses
      create_orders
      create_order_items
    end

    should "generate a baking list for category with multiple orders associated" do
      assert_equal ({"Challah Bread"=>4, "Cinnamon Swirl Bread"=>1, "Honey Wheat Bread"=>5, "Sourdough Bread"=>3}), Baking.create_baking_list_for(:breads)
    end

    should "generate an empty baking list for category with no orders associated" do
      assert Baking.create_baking_list_for(:muffins).empty?
    end

    should "generate an empty baking list for invalid category" do
      assert Baking.create_baking_list_for(:fish).empty?
    end
  end
end