require "test_helper"

class ItemTest < ActiveSupport::TestCase
  # Relationships
  should have_many(:item_prices)
  should have_many(:order_items)
  should have_many(:orders).through(:order_items)

  # Validations
  should validate_presence_of(:name)
  should validate_uniqueness_of(:name).case_insensitive
  should validate_numericality_of(:weight).is_greater_than(0)
  should validate_numericality_of(:units_per_item).only_integer.is_greater_than(0)

  # Scopes
  setup do
    create_items
  end

  teardown do
    destroy_items
  end

  should "active scope returns only active items" do
    active_items = Item.active
    active_items.must_be :all? do |item|
      item.active == true
    end
  end

  should "inactive scope returns only inactive items" do
    inactive_items = Item.inactive
    refute_empty inactive_items
    inactive_items.must_be :all? do |item|
      item.active == false
    end
  end

  should "alphabetical scope orders items by name (ignoring case)" do
    sorted_items = Item.alphabetical
    names = sorted_items.map(&:name)
    assert_equal names.sort_by { |n| n.downcase }, names
  end  

  should "breads scope returns only items in the breads category" do
    breads_items = Item.breads
    breads_items.wont_be_empty
    breads_items.each do |item|
      assert_equal "breads", item.category
    end
  end

  should "muffins scope returns only items in the muffins category" do
    muffins_items = Item.muffins
    refute_empty muffins_items
    muffins_items.each do |item|
      assert_equal "muffins", item.category
    end
  end

  should "pastries scope returns only items in the pastries category" do
    pastries_items = Item.pastries
    refute_empty pastries_items
    pastries_items.each do |item|
      assert_equal "pastries", item.category 
    end
  end
end

