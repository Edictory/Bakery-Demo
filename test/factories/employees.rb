FactoryBot.define do
  factory :employee do
    first_name { "Mark" }
    last_name { "Heimann" }
    association :user
    ssn { rand(9 ** 9).to_s.rjust(9,'0') }
    date_hired { 1.month.ago.to_date } 
    date_terminated { nil }
    active { true }
  end
end
