require 'test_helper'

class BakerAbilityTest < ActiveSupport::TestCase
  context "Within context" do
    should "verify the abilities of baker users in RDP" do
      create_baker_abilities
      # no global privileges
      deny @baker_ability.can? :manage, :all
      # testing particular abilities
      assert @baker_ability.can? :show, @honey_wheat
      assert @baker_ability.can? :index, Item
      deny @baker_ability.can? :create, Item
      deny @baker_ability.can? :update, @honey_wheat
      assert @baker_ability.can? :index, Order
      deny @baker_ability.can? :show, Order
      deny @baker_ability.can? :create, Order
      deny @baker_ability.can? :update, Order
      deny @baker_ability.can? :manage, Address
      deny @baker_ability.can? :manage, ItemPrice
    
    end
  end
end