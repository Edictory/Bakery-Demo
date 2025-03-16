require 'test_helper'

class OrderPaymentTest < ActiveSupport::TestCase
  context "Within context" do
    setup do
      create_customer_users
      create_customers
      create_addresses
      create_orders
    end

    should "have a pay method which generates a receipt string" do
      assert @melanie_o2
      assert_nil @melanie_o2.payment_receipt
      @melanie_o2.pay
      @melanie_o2.reload
      assert_not_nil @melanie_o2.payment_receipt
    end

    should "not be able to pay twice for same order" do
      assert_nil @melanie_o2.payment_receipt
      first_pay = @melanie_o2.pay
      assert_not_nil @melanie_o2.payment_receipt
      second_pay = @melanie_o2.pay
      deny second_pay # could have combined these two lines into one, but might be easier to understand this way
      assert_not_equal first_pay, second_pay
    end

    should "have a properly formatted payment receipt" do

      # test with a paid order to a non-billing address (i.e., zip code is not the order address zip)
      assert_nil @alexe_o2.payment_receipt
      @alexe_o2.pay
      assert_equal "order: #{@alexe_o2.id}; amount_paid: #{@alexe_o2.grand_total}; received: #{@alexe_o2.date}; billing_zip: #{@alexe.billing_address.zip}", Base64.decode64(@alexe_o2.payment_receipt)
      # verify with payment an order to a billing address is fine too
      assert_nil @alexe_o3.payment_receipt
      # test that the method returns the correct string when called
      assert_equal Base64.encode64("order: #{@alexe_o3.id}; amount_paid: #{@alexe_o3.grand_total}; received: #{@alexe_o3.date}; billing_zip: #{@alexe.billing_address.zip}"), @alexe_o3.pay
    end

  end
end

