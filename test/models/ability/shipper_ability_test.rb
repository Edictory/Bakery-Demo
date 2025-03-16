require 'test_helper'

class ShipperAbilityTest < ActiveSupport::TestCase
  context "Within context" do
    should "verify the abilities of shippers users in RDP" do
      create_shipper_abilities
      # no global privileges
      deny @shipper_ability.can? :manage, :all
      # testing particular abilities
      assert @shipper_ability.can? :show, @honey_wheat
      assert @shipper_ability.can? :index, Item
      deny @shipper_ability.can? :create, Item
      deny @shipper_ability.can? :update, @honey_wheat
      assert @shipper_ability.can? :index, Order
      assert @shipper_ability.can? :show, @alexe_o1
      deny @shipper_ability.can? :create, Order
      deny @shipper_ability.can? :update, Order
      deny @shipper_ability.can? :manage, Address
      assert @shipper_ability.can? :show, @alexe_a2
      deny @shipper_ability.can? :manage, ItemPrice
    end
  end
end