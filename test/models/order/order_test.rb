require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  require 'base64'

  # test relationships
  should belong_to(:customer)
  should belong_to(:address)
  should have_many(:order_items)
  should have_many(:items).through(:order_items)

  # test simple validations with matchers
  should validate_numericality_of(:grand_total).is_greater_than_or_equal_to(0)
  should allow_value(Date.today).for(:date)
  should allow_value(1.day.ago.to_date).for(:date)
  should allow_value(1.day.from_now.to_date).for(:date)
  should_not allow_value("bad").for(:date)
  should_not allow_value(2).for(:date)
  should_not allow_value(3.14159).for(:date)
 
   context "Within context" do
    setup do 
      create_customer_users
      create_customers
      create_addresses
      create_orders
    end

    should "verify that the customer is active in the system" do
      # inactive customer
      @bad_order = FactoryBot.build(:order, customer: @sherry, address: @alexe_a2, grand_total: 5.25, payment_receipt: "dcmjgwwtsd39x6wfc1", date: 5.days.ago.to_date)
      deny @bad_order.valid?
      # non-existent customer
      ghost = FactoryBot.build(:customer, first_name: "Ghost")
      non_customer_order = FactoryBot.build(:order, customer: ghost, address: @alexe_a2)
      deny non_customer_order.valid?
    end 

    should "verify that the address is active in the system" do
      # inactive address
      @bad_order = FactoryBot.build(:order, customer: @alexe, address: @alexe_a3, grand_total: 5.25, payment_receipt: "dcmjgwwtsd39x6wfc1", date: 5.days.ago.to_date)
      deny @bad_order.valid?
      # non-existent address
      ghost = FactoryBot.build(:address, customer: @alexe, recipient: "Ghost")
      non_address_order = FactoryBot.build(:order, customer: @alexe, address: ghost)
      deny non_address_order.valid?
    end
 
    should "callback overwrites any provided date with Date.current" do
      @order = FactoryBot.build(:order, customer: @melanie, address: @melanie_a1, grand_total: 69.0, payment_receipt: "aslkdjaslkdj", date: Date.yesterday)
      @order.save!
      assert_equal Date.current, @order.date
    end

    should "not change order data upon update" do
      @order = FactoryBot.create(:order, customer: @melanie, address: @melanie_a1, grand_total: 69.0, payment_receipt: "aslkdjaslkdj", date: Date.yesterday)
      original_order_date = @order.date
      @order.update!(grand_total: 100.0)
      assert_equal original_order_date, @order.date
    end
  end
end

