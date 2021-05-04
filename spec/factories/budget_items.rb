FactoryBot.define do
  factory :budget_item do
    name { "Budget Item" }
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

    trait :recurring do
      is_recurring { true }
    end

    trait :not_recurring do
      is_recurring { false }
    end
    
  end
end
