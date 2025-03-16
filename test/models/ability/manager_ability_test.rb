require 'test_helper'

class ManagerAbilityTest < ActiveSupport::TestCase
  context "Within context" do
    should "verify the abilities of manager users to do everything" do
      create_manager_abilities
      assert @mark_ability.can? :manage, :all
    end
  end
end