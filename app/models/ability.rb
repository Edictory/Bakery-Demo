class Ability
  include CanCan::Ability

  def initialize(user)
    # if no user is logged in, create a guest user
    user ||= User.new

    if user.manager_role?
      # Managers can do everything.
      can :manage, :all

    elsif user.baker_role?
      # Bakers can read Items.
      can [:index, :show], Item
      # They cannot create or update Items.
      # They can list Orders but cannot view, create, or update an individual Order.
      can :index, Order

    elsif user.shipper_role?
      # Shippers can read Items.
      can [:index, :show], Item
      # They can list and view Orders.
      can [:index, :show], Order
      can :update, OrderItem
      can :show, Address

    elsif user.customer_role?
      # Customers can read Items.
      can [:index, :show], Item
      can :read, ItemPrice

      can :create, Order
      # They can show and update orders that belong to them.
      can [:show, :index, :checkout, :add_to_cart], Order do |order|
        user.customer.orders.map(&:id).include? order.id
      end
      # Addresses: They can create, index, and manage only their own addresses.
      can :create, Address
      can :index, Address
      can [:show, :update], Address do |address|
        address.customer.id == user.customer.id
      end

      can [:show, :update], User do |user1|
        user1.id == user.id
      end
      # Customers: They can read and update their own customer record.
      can [:show, :update], Customer do |customer|
        customer.id == user.customer.id
      end
      # Guests: can read Items and create a Customer account.
    can [:index, :show], Item
    can :create, Customer
    end
  end
end
