module Contexts
  module Customers
    def create_customers
      # assumes no users exist
      # @alexe   = FactoryBot.create(:customer, first_name: "Alex", last_name: "Egan")
      # @melanie = FactoryBot.create(:customer, first_name: "Melanie", last_name: "Freeman")
      # @anthony = FactoryBot.create(:customer, first_name: "Anthony", last_name: "Corletti", phone: "412-268-2323")
      # @ryan    = FactoryBot.create(:customer, first_name: "Ryan", last_name: "Flood")
      # @sherry  = FactoryBot.create(:customer, first_name: "Sherry", last_name: "Chen", active: false)

      ### assumes create_users prior
      @alexe   = FactoryBot.create(:customer, user: @u_alexe, first_name: "Alex", last_name: "Egan")
      @melanie = FactoryBot.create(:customer, user: @u_melanie, first_name: "Melanie", last_name: "Freeman")
      @anthony = FactoryBot.create(:customer, user: @u_anthony, first_name: "Anthony", last_name: "Corletti", phone: "412-268-2323")
      @ryan    = FactoryBot.create(:customer, user: @u_ryan, first_name: "Ryan", last_name: "Flood")
      @sherry  = FactoryBot.create(:customer, user: @u_sherry, first_name: "Sherry", last_name: "Chen", active: false)
    end
    
    def destroy_customers
      @alexe.delete
      @melanie.delete
      @anthony.delete
      @ryan.delete 
      @sherry.delete
    end

  end
end