FactoryBot.define do
  sequence :email do |n|
    "sequence-user#{n}@email.com"
  end
  factory :user do
    email
    password { "password" }
  end
end
