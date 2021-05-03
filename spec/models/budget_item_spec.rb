require 'rails_helper'

RSpec.describe BudgetItem, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:type) }
    it { should validate_presence_of(:is_recurring) }
    it { should validate_presence_of(:amount) }
    it { should validate_presence_of(:date) }
    it { should validate_inclusion_of(:recur_unit)
         .in_array(["months", "weeks", "days"])}
  end

  describe 'associations' do
    it { should belong_to(:user) }
  end
end
