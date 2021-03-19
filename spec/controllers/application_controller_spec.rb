require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  controller do
  end

  describe '#sign_in!' do 
    before(:each) do 
      @user = FactoryBot.build(:user)
      @controller.sign_in!(@user)
    end

    it 'sets the session token to the user\'s' do 
      expect(session[:session_token]).to eq(@user.session_token)
    end
  end

  describe '#sign_out!' do
    before(:each) do 
      @user = FactoryBot.build(:user)
      @initial_token = @user.session_token
      session[:session_token] = @user.session_token
      @controller.sign_out!(@user)
    end

    it 'sets the session token to nil' do 
      expect(session[:session_token]).to be_nil
    end

    it 'changes the user\'s session token' do
      expect(@user.session_token).to_not eq(@initial_token)
    end
  end

  describe 'current_user' do
    context 'when a user is logged in' do
      before(:each) do 
        @user = FactoryBot.create(:user)
        session[:session_token] = @user.session_token
      end

      after(:each) do 
        @user.destroy
      end

      it 'returns the user who is logged in' do
        session_token = session[:session_token]
        expect(@controller.current_user.id).to eq(@user.id)
      end
    end

    context 'when no user is logged in' do
      it 'returns nil' do
        expect(@controller.current_user).to be_nil
      end
    end
  end
end
