FactoryBot.define do
  factory :recurring_item do
    name { "Recurring Item" }
    amount { 10.00 }
    start_date { DateTime.now() }
    type { "expense" }
    recur_period { 1 }
    recur_unit_type { "MonthsUnitItem" }
    user

    trait :expense do 
      type { "expense" }
    end

    trait :income do
      type { "income" }
    end

    factory :days_item, class: 'DaysUnitItem' do
      recur_unit_type { "DaysUnitItem" }
    end

    factory :months_item, class: 'MonthsUnitItem' do
      recur_unit_type { "MonthsUnitItem" }
    end
  end
end
