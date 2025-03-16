FactoryBot.define do
  factory :user do
    sequence :username do |n|
      "user#{n}"
    end
    password { "secret" }
    password_confirmation { "secret" }
    role { 1 }
    active { true }
  end
end
