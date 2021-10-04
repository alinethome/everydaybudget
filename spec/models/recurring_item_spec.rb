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

    describe 'validate that the recur period is positive' do 
      let(:negative_months_item) { FactoryBot.build(:months_item,
                                                    :expense, 
                                                    recur_period: -3) }

      let(:zero_months_item) { FactoryBot.build(:months_item,
                                                :income, 
                                                recur_period: 0) }

      before :all do 
        @user = FactoryBot.create(:user)
      end

      after :all do 
        @user.destroy
      end

      describe 'given an item with a negative recur period' do 
        it 'is invalid' do
          negative_months_item.user_id = @user.id
          puts negative_months_item.recur_period
          expect(negative_months_item).to_not be_valid
        end
      end

      describe 'given an item with a zero recur period' do 
        it 'is invalid' do 
          zero_months_item.user_id = @user.id
          expect(zero_months_item).to_not be_valid
        end
      end
    end
  end

  describe 'associations' do
    it { should belong_to(:user) }
  end
end
