require 'rails_helper'

RSpec.describe Api::SessionsController, type: :controller do
  describe 'POST #create' do
    context 'with valid email and password' do
      before(:each) do 
        @attributes_for_user = FactoryBot.attributes_for(:user)
        @user = User.create(@attributes_for_user) 
        post :create,
          params: { user: @attributes_for_user },
          format: :json
      end

      after(:each) do
        @user.destroy
      end

      it 'signs the user in' do
        expect(session[:session_token]).to eq(@user.session_token)
      end

      it 'renders the user as json' do 
        expect(response).to render_template(:show)
      end
    end

    context 'with invalid email and password' do
      before(:each) do
        @attributes_for_user = { email: '', password: ''} 
        session[:session_token] = nil
      end

      it 'does not sign the user in' do
        post :create,
          params: { user: @attributes_for_user },
          format: :json

        expect(session[:session_token]).to be_nil
      end

      it 'renders a json error hash' do
        post :create,
          params: { user: @attributes_for_user }
        expect(response.header['Content-Type']).to include 'application/json'
      end

      it 'returns an unauthorized status code' do
        post :create,
          params: { user: @attributes_for_user }
        expect(response).to have_http_status(401)
      end
    end
  end

  describe "DELETE #destroy" do 
    before(:each) do 
      @user = FactoryBot.create(:user) 
      session[:session_token] = @user.session_token
    end

    it 'signs the user out' do
      delete :destroy, params: { id: @user.id }
      expect(session[:session_token]).to be_nil
    end

    it 'sends a 204 response' do
      delete :destroy, params: { id: @user.id }
      expect(response).to have_http_status(204)
    end
  end
end
