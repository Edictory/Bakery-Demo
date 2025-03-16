module Contexts
  module Users
    # Context for users
    def create_customer_users
      @u_alexe   = FactoryBot.create(:user, username: "alexe")
      @u_melanie = FactoryBot.create(:user, username: "melanie")
      @u_anthony = FactoryBot.create(:user, username: "anthony")
      @u_ryan    = FactoryBot.create(:user, username: "ryan")
      @u_sherry  = FactoryBot.create(:user, username: "sherry", active: false)
    end
    
    def destroy_customer_users
      @u_alexe.delete
      @u_melanie.delete
      @u_anthony.delete
      @u_ryan.delete 
      @u_sherry.delete
    end

    def create_employee_users
      @u_alex   = FactoryBot.create(:user, username: "tank", role: 4)
      @u_mark   = FactoryBot.create(:user, username: "mark", role: 4)
      @u_cindy  = FactoryBot.create(:user, username: "cindy", role: 2)
      @u_ralph  = FactoryBot.create(:user, username: "ralph", role: 3)
      @u_chuck  = FactoryBot.create(:user, username: "chuck", role: 3)
      @u_terry  = FactoryBot.create(:user, username: "terry", role: 2, active: false)

    end

  end
end