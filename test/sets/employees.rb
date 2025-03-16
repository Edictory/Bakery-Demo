module Contexts
  module Employees

    def create_employees
      @mark = FactoryBot.create(:employee)
      @cindy = FactoryBot.create(:employee, user: @u_cindy, first_name: "Cindy", last_name: "Crawford", ssn: "084-35-9822")
      @ralph = FactoryBot.create(:employee, user: @u_ralph, first_name: "Ralph", last_name: "Wilson")
      @chuck = FactoryBot.create(:employee, user: @u_chuck, first_name: "Chuck", last_name: "Waldo", active: false)
    end
    
    def destroy_employees
      @mark.destroy
      @cindy.destroy
      @ralph.destroy
      @chuck.destroy  
    end

  end
end