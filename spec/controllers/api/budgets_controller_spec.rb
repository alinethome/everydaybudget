require 'rails_helper'

RSpec.describe Api::BudgetsController, type: :controller do
  before do
    @user = FactoryBot.create(:user)
  end

  after do
    @user.destroy
  end

  describe 'get #show' do
    context 'given a user is logged in' do
      before do
        session[:session_token] = @user.session_token
      end

      it 'renders the budget info for that user as json' do
        get :show, format: :json
        expect(response).to render_template(:show)
      end
    end

    context 'given no one is logged in' do
      before do 
        session[:session_token]
      end

      it 'returns a json response' do
        get :show, format: :json
        expect(response.header['Content-Type']).to include 'application/json'
      end

      it 'returns a 403 status code' do
        get :show, format: :json
        expect(response).to have_http_status(403)
      end
    end
  end
end
