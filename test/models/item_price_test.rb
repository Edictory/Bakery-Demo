require "test_helper"

class ItemPriceTest < ActiveSupport::TestCase
  should belong_to(:item)

  should validate_numericality_of(:price).is_greater_than_or_equal_to(0)

  # Scopes: setup and teardown using context methods
  setup do
    create_items
    create_item_prices
  end

  teardown do
    destroy_item_prices
    destroy_items
  end

  # Test for current scope: now only returns prices where end_date is nil.
  should "current scope returns only prices that are current (end_date is nil)" do
    current_prices = ItemPrice.current
    current_prices.each do |price|
      assert_nil price.end_date, "Expected current price to have nil end_date, but got #{price.end_date}"
    end
  end

  should "excludes item prices with a future start_date from being effective on a given date" do
    # Set one price's start_date to tomorrow so it should not be effective today in the for_date scope.
    @hw1.update(start_date: Date.current + 1)
    prices_for_today = ItemPrice.for_date(Date.current)
    refute_includes prices_for_today, @hw1
  end

  should "for_date scope returns only prices effective on the given date" do
    today = Date.today
    prices_for_today = ItemPrice.for_date(today)
    refute_empty prices_for_today, "Expected at least one price effective today"
    prices_for_today.each do |price|
      assert_operator price.start_date, :<=, today, "Price's start_date #{price.start_date} should be on or before #{today}"
      assert (price.end_date.nil? || price.end_date > today), "Price's end_date (#{price.end_date}) should be nil or greater than #{today}"
    end
  end

  should "for_item scope returns only item prices for a given item" do
    # Test for @honey_wheat item prices.
    honey_wheat_prices = ItemPrice.for_item(@honey_wheat.id)
    refute_empty honey_wheat_prices, "Expected to find some prices for @honey_wheat"
    honey_wheat_prices.each do |price|
      assert_equal @honey_wheat.id, price.item_id, "Expected item_id #{price.item_id} to equal #{@honey_wheat.id}"
    end
  end

  should "chronological scope returns item prices ordered by start_date descending" do
    ordered_prices = ItemPrice.chronological.to_a
    # Check that each price's start_date is greater than or equal to the next one's start_date.
    ordered_prices.each_cons(2) do |price1, price2|
      assert_operator price1.start_date, :>=, price2.start_date, "Expected #{price1.start_date} to be >= #{price2.start_date}"
    end
  end
end
