require 'rails_helper'

RSpec.describe RecurringItem, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:type) }
    it { should validate_presence_of(:amount) }
    it { should validate_presence_of(:start_date) }
    it { should validate_presence_of(:recur_unit_type) }
    it { should validate_presence_of(:recur_period) }
    it { should validate_inclusion_of(:recur_unit_type)
         .in_array(["MonthsUnitItem", "DaysUnitItem"])}
    it { should validate_inclusion_of(:type)
         .in_array(["income", "expense"])}
  end

  describe 'associations' do
    it { should belong_to(:user) }
  end
end
