require 'rails_helper'

RSpec.describe User, type: :model do
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
end
