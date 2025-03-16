require 'test_helper'

class AddressTest < ActiveSupport::TestCase
  # test relationships
  should belong_to(:customer)
  should have_many(:orders)

  # test validations with matchers
  should validate_presence_of(:recipient)
  should validate_presence_of(:street_1)
  should validate_presence_of(:zip)

  # should validate_inclusion_of(:state).in_array(['PA','WV'])
  should allow_value("PA").for(:state)
  should allow_value("WV").for(:state)
  # should allow_value(nil).for(:state)
  should_not allow_value("OH").for(:state)
  should_not allow_value("pa").for(:state)
  should_not allow_value("NY").for(:state)
  should_not allow_value("NJ").for(:state)
  should_not allow_value("DE").for(:state)


  should allow_value("12345").for(:zip)
  should_not allow_value("1234").for(:zip)
  should_not allow_value("123456").for(:zip)
  should_not allow_value("12345-0001").for(:zip)
  should_not allow_value("1234I").for(:zip)
  should_not allow_value(nil).for(:zip)

  context "Within context" do
    setup do
      create_customer_users
      create_customers
      create_addresses
    end

    # testing some non-standard validations
    should "verify that the customer is active in the system" do
      # test the inactive customer first
      bad_address = FactoryBot.build(:address, customer: @sherry, recipient: "Sherry Chen", is_billing: true, active: true)
      deny bad_address.valid?
      # test the nonexistent customer
      ghost = FactoryBot.build(:customer, first_name: "Ghost")
      non_customer_address = FactoryBot.build(:address, customer: ghost)
      deny non_customer_address.valid?
    end 

    should "verify customer's address for this recipient is not already in the system" do
      bad_address = FactoryBot.build(:address, customer: @alexe, recipient: "Jeff Egan", is_billing: false, zip: "15212")
      deny bad_address.valid?
    end 

    should "allow an address 'duplication' if it belongs to a different customer" do
      # same address as before, but belongs now to Melanie instead of Alex
      good_address = FactoryBot.build(:address, customer: @melanie, recipient: "Jeff Egan", is_billing: false, zip: "15212")
      assert good_address.valid?
    end

    should "unset old billing address when new one set" do
      # confirm the current billing address
      assert_equal @alexe_a1, @alexe.billing_address
      refute_equal @alexe_a2, @alexe.billing_address
      # change the billing address to address 2
      @alexe_a2.is_billing = true
      @alexe_a2.save
      # confirm that address 1 no longer billing
      refute_equal @alexe_a1, @alexe.billing_address
      # confirm that address 2 is now billing
      assert_equal @alexe_a2, @alexe.billing_address
    end

    should "not allow an active billing address to be made inactive" do
      assert @alexe_a1.active
      assert @alexe_a1.is_billing
      @alexe_a1.is_billing = false
      deny @alexe_a1.save
    end

    should "not allow a customer's first address to be non-billing" do
      # Sherry was inactive, so she has no addresses right now
      @sherry.make_active
      # build a non-billing address
      @sherry_a1  = FactoryBot.build(:address, customer: @sherry, recipient: "Sherry Chen", is_billing: false)
      deny @sherry_a1.valid?
      # build an inactive billing address
      @sherry_a2  = FactoryBot.build(:address, customer: @sherry, recipient: "Sherry Chen", is_billing: true, active: false)
      deny @sherry_a2.valid?
    end

  end
end