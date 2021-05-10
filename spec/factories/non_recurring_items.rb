FactoryBot.define do
  factory :non_recurring_item do
    name { "Non Recurring Item" }
    amount { 10.00 }
    date { DateTime.now() }
    type { "expense" }
    user

    trait :expense do 
      type { "expense" }
    end

    trait :income do
      type { "income" }
    end
  end
end
