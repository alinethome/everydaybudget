require 'rails_helper'

RSpec.describe Api::UsersController, type: :controller do
  describe 'POST #create' do 
    context 'with valid parameters' do 
      it 'renders the newly created user as json' do
        post :create, 
          params: { user: FactoryBot.attributes_for(:user) }, 
          format: :json
        expect(response).to render_template(:show)
      end

      it 'creates a new user' do 
        expect{
          post :create, params: { user: FactoryBot.attributes_for(:user) },
          format: :json
        }.to change(User, :count).by(1)
      end
    end

    context 'with invalid parameters' do 
      it 'does not create a new user' do 
        expect{
          post :create, params: { user: { email: '', 
                                          password: '' } }, format: :json
        }.to_not change(User, :count)
      end

      it 'returns an unprocessable entity status' do
        post :create, 
          params: { user: { email: '', password: '' }},
          format: :json
        expect(response).to have_http_status(422)
      end

      it 'returns a json response' do 
        post :create, 
          params: { user: { email: '', password: '' }},
          format: :json
      end
    end
  end
end
