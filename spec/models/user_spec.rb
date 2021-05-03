require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do 
    subject(:user) { FactoryBot.build(:user) }

    let(:bad_email1) { "useremail.net" }
    let(:bad_email2) { "user@emailnet" }
    let(:bad_email3) { "us/r@email.net" }
    let(:bad_email4) { "user@em?il.net" }

    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password_digest) }
    it { should validate_presence_of(:session_token) }
    it { should validate_uniqueness_of(:email) }
    it { should validate_length_of(:password).is_at_least(8) }

    context 'when given an invalid email' do 
      it 'should raise be invalid' do 
        password = "password"

        expect(FactoryBot.build(:user, email: bad_email1)).to_not be_valid
        expect(FactoryBot.build(:user, email: bad_email2)).to_not be_valid
        expect(FactoryBot.build(:user, email: bad_email3)).to_not be_valid
        expect(FactoryBot.build(:user, email: bad_email4)).to_not be_valid
      end

      it 'should raise an error' do
        bad_email1 = "useremail.net"
        password = "password"
        user = FactoryBot.build(:user, email: bad_email1) 
        user.save

        expect(user.errors.full_messages).
          to include("Email is not a valid email address")
      end
    end

    context 'when given a valid email' do 
      it 'should be valid' do 
        expect(user).to be_valid
      end
    end
  end

  describe 'associations' do
    it { should have_many(:budget_items).dependent(:destroy) }
  end

  describe '::find_by_credentials' do
    before(:all) do 
      @user = FactoryBot.create(:user)
    end

    after(:all) do 
      @user.destroy
    end

    context 'given a nonexistent email' do 
      it 'returns nil' do 
        expect(User.find_by_credentials('notauser@email.com', 'password')).to be_nil
      end
    end

    context 'given the correct credentials' do 
      it 'returns the user to whom those credentials belong' do 
        expect(User.find_by_credentials(@user.email, 
                                        @user.password).id).to eq(@user.id)
      end
    end

    context 'given an existing email but the wrong password' do 
      it 'returns nil' do 
        expect(User.find_by_credentials(@user.email, 'notpassword')).to be_nil
      end
    end
  end

  describe '#password=' do 
    it 'sets the password' do 
      password = "password"
      user_with_pass = FactoryBot.build(:user, password: password)

      expect(user_with_pass.password).to eq("password")
    end
  end

  describe 'is_password?' do 
    let (:user_with_pass) { User.new(email: 'user@email.com',
                                     password: 'password')}

    context 'given the wrong password' do 
      it 'returns false' do 
        expect(user_with_pass.is_password?("Password")).to be false
        expect(user_with_pass.is_password?("pass")).to be false
        expect(user_with_pass.is_password?("passrord")).to be false
      end 
    end

    context 'given an empty password' do 
      it 'returns false' do 
        expect(user_with_pass.is_password?("")).to be false
      end
    end

    context 'given the correct password' do 
      it 'returns true' do 
        expect(user_with_pass.is_password?("password")).to be true
      end
    end
  end

  describe '#ensure_session_token' do 
    let (:user) { FactoryBot.build(:user) }

    context 'given a user with no session token' do 
      it 'assigns a session token' do 
        user.session_token = nil
        user.ensure_session_token

        expect(user.session_token).to_not be_nil
      end
    end

    context 'given a user with a session token' do 
      it 'does not change the token' do 
        sample_token = "sample token"
        user.session_token = sample_token

        expect(user.session_token).to eq(sample_token)
      end
    end

    context 'on a new user' do 
      it 'is run on initialisation to assign them a token' do 
        expect(user.session_token).to_not be_nil
      end
    end
  end

  describe '#reset_session_token!' do 
    let(:user) { FactoryBot.create(:user) }

    it 'resets the user\'s session token' do 
      old_token = user.session_token
      user.reset_session_token!

      expect(user.session_token).to_not eq(old_token)
    end

    it 'persists the change' do 
      old_token = user.session_token
      user.reset_session_token!
      
      expect(User.find(user.id).session_token).to_not eq(old_token)
    end
  end
end
