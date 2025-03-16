require 'test_helper'

class AddressTest < ActiveSupport::TestCase
  context "Within context" do
    setup do
      create_customer_users
      create_customers
      create_addresses
    end

    # testing some callbacks and other methods
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

    should "allow an existing address to be edited" do
      @alexe_a1.street_1 = "5005 Forbes Avenue"
      assert @alexe_a1.valid?
    end

    should "make sure an billing address stays active even if attempting to make inactive" do
      assert @alexe_a1.active
      assert @alexe_a1.is_billing
      @alexe_a1.active = false
      deny @alexe_a1.valid?
    end

    should "have make_active and make_inactive methods" do
      assert @alexe_a2.active
      @alexe_a2.make_inactive
      @alexe_a2.reload
      deny @alexe_a2.active
      @alexe_a2.make_active
      @alexe_a2.reload
      assert @alexe_a2.active
    end
  end
end