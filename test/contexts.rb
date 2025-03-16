# require needed files
require './test/sets/users'
require './test/sets/customers'
require './test/sets/employees'
require './test/sets/addresses'
require './test/sets/items'
require './test/sets/item_prices'
require './test/sets/orders'
require './test/sets/order_items'
require './test/sets/abilities'
require './test/sets/credit_cards'


module Contexts
  # explicitly include all sets of contexts used for testing 
  include Contexts::Users
  include Contexts::Customers
  include Contexts::Addresses
  include Contexts::Employees
  include Contexts::Items
  include Contexts::ItemPrices
  include Contexts::CreditCards
  include Contexts::Orders
  include Contexts::OrderItems
  include Contexts::Abilities

  def create_all
    puts "Building context..."
    create_customer_users
    puts "Built customer users"
    create_customers
    puts "Built customers"
    create_addresses
    puts "Built addresses"
    create_employee_users
    puts "Built employee users"
    create_employees
    puts "Built employees"
    create_items
    puts "Built items"
    create_item_prices
    puts "Assign prices to items"
    create_orders
    puts "Built orders"
    create_order_items
    puts "Added items to orders"
    puts "Finished basic contexts"
  end

  def destroy_all
    OrderItem.all.each{|x| x.delete}
    Order.all.each{|x| x.delete}
    ItemPrice.all.each{|x| x.delete}
    Item.all.each{|x| x.delete}
    Employee.all.each{|x| x.delete}
    Address.all.each{|x| x.delete}
    Customer.all.each{|x| x.delete}
    User.all.each{|x| x.delete}
  end


end