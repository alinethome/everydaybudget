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

      it 'logs in the newly created user' do
        expect(subject).to receive(:sign_in!)
        post :create,
          params: { user: FactoryBot.attributes_for(:user) },
          format: :json
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
          params: { user: { email: '', password: '' }}
        expect(response.header['Content-Type']).to include 'application/json'
      end
    end
  end

  describe 'DELETE #destroy' do 
    before (:each) do 
      @user = FactoryBot.create(:user)
    end

    after (:each) do 
      @user.destroy
    end

    context 'with valid id' do 
      it 'renders the destroyed user as json' do
        delete :destroy, params: { id: @user.id }, format: :json
        expect(response).to render_template(:show)
      end

      it 'destroys the user' do 
        expect{
          delete :destroy, params: { id: @user.id }, format: :json
        }.to change(User, :count).by(-1)
      end
    end

    context 'with invalid id' do 
      it 'does not destroy anything' do 
        expect{
          delete :destroy, params: { id: -1 }, format: :json
        }.to_not change(User, :count)
      end

      it 'returns a json response' do
        delete :destroy, params: { id: -1 }
        expect(response.header['Content-Type']).to include 'application/json'
      end
    end
  end

  describe 'PUT #update' do
    before (:each) do 
      @user = FactoryBot.create(:user)
    end

    after (:each) do 
      @user.destroy
    end

    context 'with valid id and user params' do 
      before (:each) do 
        @new_user_attributes = FactoryBot.attributes_for(:user)
        put :update, 
          params: { id: @user.id, user: @new_user_attributes }, 
          format: :json
      end

      it 'updates the user' do 
        put :update, 
          params: { id: @user.id, user: @new_user_attributes }, 
          format: :json
        user = User.find(@user.id)
        expect(user.email).to eq(@new_user_attributes[:email])
      end

      it 'returns the updated user formatted as json' do 
        expect(response).to render_template(:show)
      end
    end

    context 'with invalid attributes' do 
      it 'does not modify the user' do 
        put :update, 
          params: { id: @user.id, user: { email: "", password: "" } }, 
          format: :json
        user = User.find(@user.id)
        expect(user.email).to eq(@user.email)
        expect(user.is_password?(@user.password)).to be true
      end

      it 'returns a json response' do
        put :update, 
          params: { id: @user.id, user: { email: "", password: "" } }
        expect(response.header['Content-Type']).to include 'application/json'
      end

      it 'returns a bad request status code' do
        put :update, 
          params: { id: @user.id, user: { email: "", password: "" } }, 
          format: :json
        expect(response).to have_http_status(400)
      end
    end
  end

  describe 'GET #show' do 
    before(:all) do 
      @user = FactoryBot.create(:user) 
    end

    after(:all) do 
      @user.destroy
    end

    context 'given a valid id' do 
      it 'renders the user as json' do 
        get :show, params: { id: @user.id }, format: :json
        expect(response).to render_template(:show)
      end
    end

    context 'given an invalid id' do
      it 'returns a json response' do
        get :show, params: { id: -1 }
        expect(response.header['Content-Type']).to include 'application/json'
      end
    end
  end
end
