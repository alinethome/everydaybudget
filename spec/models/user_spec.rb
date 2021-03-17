require 'rails_helper'

RSpec.describe User, type: :model do
  describe '::find_by_credentials' do
    before(:all) do 
      user = User.new(email: 'user@email.com', password: 'password')
      user.save
    end

    context 'given a nonexistent email' do 
      it 'returns nil' do 
        expect(User.find_by_credentials('notauser@email.com', 'password')).to be_nil
      end
    end

    context 'given the correct credentials' do 
      it 'returns the user to whom those credentials belong' do 
        user = User.find_by(email: 'user@email.com')
        expect(User.find_by_credentials('user@email.com', 
                                        'password').id).to eq(user.id)
      end
    end

    context 'given an existing email but the wrong password' do 
      it 'returns nil' do 
        expect(User.find_by_credentials('user@email.com', 'notpassword')).to be_nil
      end
    end
  end

  describe '#password=' do 
    let (:user_with_pass) { User.new(email: 'user@email.com',
                                     password: 'password')}
    it 'sets the password' do 
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
    let (:user) { User.new(email: 'user@email.com',
                                     password: 'password')}

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
    let (:user) { User.new(email: 'user@email.com',
                                     password: 'password',
                          session_token: 'sample token')}
    it 'resets the user\'s session token' do 
      old_token = user.session_token
      user.reset_session_token!

      expect(user.session_token).to_not eq(old_token)
    end

    it 'persists the change' do 
      user.save
      old_token = user.session_token
      user.reset_session_token!
      
      expect(User.find(user.id).session_token).to_not eq(old_token)
    end
  end
end
