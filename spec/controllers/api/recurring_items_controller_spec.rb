require 'rails_helper'

RSpec.describe Api::RecurringItemsController, type: :controller do
  let(:good_params) { FactoryBot.attributes_for(:recurring_item, amount: 314) }
  let(:bad_params) { FactoryBot.attributes_for(:recurring_item, amount: '')}

  before do 
    @user = FactoryBot.create(:user)
    @wrong_user = FactoryBot.create(:user)
  end

  after do
    @user.destroy
    @wrong_user.destroy
  end


  describe 'POST #create' do
    context 'if there is no logged in user' do
      before do 
        session[:session_token] = nil 
      end

      it 'does not create a new item' do
        expect{
          post :create, 
          params: { user_id: @user.id,
                    item: FactoryBot.attributes_for(:days_item)},
        format: :json
        }.to_not change(DaysUnitItem, :count)
      end

      it 'returns a json response' do
        post :create,
          params: { user_id: @user.id,
                    item: FactoryBot.attributes_for(:days_item) },
        format: :json
        expect(response.header['Content-Type']).to include 'application/json'
      end

      it 'returns a forbidden status code' do
        post :create,
          params: { user_id: @user.id,
                    item: FactoryBot.attributes_for(:days_item) },
        format: :json
        expect(response).to have_http_status(403)
      end
    end

    context 'with a logged in user' do
      before do 
        session[:session_token] = @user.session_token
      end

      after do 
        session[:session_token] = nil 
      end

      context 'with valid parameters' do
        context 'if they\'re for an item with a recur period in days' do
          it 'renders the newly created item as json' do
            post :create,
              params: { user_id: @user.id,
                        item: FactoryBot.attributes_for(:days_item) },
            format: :json
            expect(response).to render_template(:show)
          end

          it 'creates a new days unit budget item' do
            expect{
              post :create, 
              params: { user_id: @user.id,
                        item: FactoryBot.attributes_for(:days_item)},
            format: :json
            }.to change(DaysUnitItem, :count).by(1)
          end
        end

        context 'if they\'re for an item with a recur period in months' do
          it 'renders the newly created item as json' do
            post :create,
              params: { user_id: @user.id,
                        item: FactoryBot.attributes_for(:months_item) },
            format: :json
            expect(response).to render_template(:show)
          end

          it 'creates a new days unit budget item' do
            expect{
              post :create, 
              params: { user_id: @user.id,
                        item: FactoryBot.attributes_for(:months_item)},
            format: :json
            }.to change(MonthsUnitItem, :count).by(1)
          end
        end
      end

      context 'with invalid parameters' do 
        it 'does not create a new budget item' do
          expect{
            post :create, params: { user_id: @user.id,
                                    item: bad_params }, format: :json
          }.to_not change(RecurringItem, :count)
        end

        it 'returns an unprocessable entity status' do
          post :create, params: { user_id: @user.id,
                                  item: bad_params }, format: :json

          expect(response).to have_http_status(422)
        end

        it 'returns a json response' do
          post :create, params: { user_id: @user.id,
                                  item: bad_params }, format: :json

          expect(response.header['Content-Type']).to include 'application/json'
        end
      end
    end
  end

  describe 'DELETE #destroy' do
    before(:each) do 
      @days_item = FactoryBot.create(:days_item, user_id: @user.id)
    end

    after(:each) do
      @days_item.destroy
    end

    context 'with no logged in user' do
      before do
        session[:session_token] = nil
      end

      it 'does not destroy the item' do
        expect{
          delete :destroy, params: { id: @days_item.id }, format: :json
        }.to_not change(DaysUnitItem, :count)
      end

      it 'returns a json response' do
        delete :destroy, params: { id: @days_item.id }, format: :json
        expect(response.header['Content-Type']).to include 'application/json'
      end

      it 'returns a forbidden status code' do
        delete :destroy, params: { id: @days_item.id }, format: :json
        expect(response).to have_http_status(403)
      end
    end

    context 'with the wrong user logged in' do 
      before do
        session[:session_token] = @wrong_user.session_token
      end

      after do
        session[:session_token] = nil
      end

      it 'does not destroy the item' do
        expect{
          delete :destroy, params: { id: @days_item.id }, format: :json
        }.to_not change(DaysUnitItem, :count)
      end

      it 'returns a json response' do
        delete :destroy, params: { id: @days_item.id }, format: :json
        expect(response.header['Content-Type']).to include 'application/json'
      end

      it 'returns a forbidden status code' do
        delete :destroy, params: { id: @days_item.id }, format: :json
        expect(response).to have_http_status(403)
      end
    end

    context 'with the owner logged in' do
      before do
        session[:session_token] = @user.session_token
      end

      after do
        session[:session_token] = nil
      end

      context 'with valid id' do
        it 'renders the destroyed item as json' do
          delete :destroy, params: { id: @days_item.id }, format: :json
          expect(response).to render_template(:show)
        end

        it 'destroys the item' do
          expect{
            delete :destroy, params: { id: @days_item.id }, format: :json
          }.to change(DaysUnitItem, :count).by(-1)
        end
      end

      context 'with invalid id' do
        it 'does not destroy anything' do
          expect{
            delete :destroy, params: { id: -1 }, format: :json
          }.to_not change(RecurringItem, :count)
        end

        it 'returns a json response' do
          delete :destroy, params: { id: -1 }
          expect(response.header['Content-Type']).to include 'application/json'
        end
      end
    end
  end

  describe 'PUT #update' do
    before(:each) do 
      @recurring_item = FactoryBot.create(:recurring_item, 
                                          amount: 0,
                                          user_id: @user.id)
    end

    after(:each) do
      @recurring_item.destroy
    end

    context 'with no user signed in' do
      before do
        session[:session_token] = nil
      end

      it 'does not update the item' do
        put :update, 
          params: { id: @recurring_item.id, item: good_params }, 
          format: :json

        item = RecurringItem.find(@recurring_item.id)
        expect(item.amount).to eq(@recurring_item.amount)
      end

      it 'returns a json response' do
        put :update, 
          params: { id: @recurring_item.id, item: good_params }, 
          format: :json

        expect(response.header['Content-Type']).to include 'application/json'
      end

      it 'returns a 403 status code' do
        put :update, 
          params: { id: @recurring_item.id, item: good_params }, 
          format: :json

        expect(response).to have_http_status(403)
      end
    end

    context 'with the wrong user signed in' do
      before do
        session[:session_token] = @wrong_user.session_token
      end

      after do
        session[:session_token] = nil
      end

      it 'does not update the item' do
        put :update, 
          params: { id: @recurring_item.id, item: good_params }, 
          format: :json

        item = RecurringItem.find(@recurring_item.id)
        expect(item.amount).to eq(@recurring_item.amount)
      end

      it 'returns a json response' do
        put :update, 
          params: { id: @recurring_item.id, item: good_params }, 
          format: :json

        expect(response.header['Content-Type']).to include 'application/json'
      end

      it 'returns a 403 status code' do
        put :update, 
          params: { id: @recurring_item.id, item: good_params }, 
          format: :json

        expect(response).to have_http_status(403)
      end
    end

    context 'with the owner signed in' do
      before do
        session[:session_token] = @user.session_token
      end

      after do 
        session[:session_token] = nil
      end

      context 'with valid id and item params' do
        it 'updates the item' do
          put :update, 
            params: { id: @recurring_item.id, item: good_params }, 
            format: :json

          item = RecurringItem.find(@recurring_item.id)
          expect(item.amount).to eq(good_params[:amount])
        end

        it 'returns the updated item formatted as json' do
          put :update, 
            params: { id: @recurring_item.id, item: good_params }, 
            format: :json

          expect(response).to render_template(:show)
        end
      end

      describe 'with invalid attributes' do
        it 'does not modify the item' do
          put :update, 
            params: { id: @recurring_item.id, item: bad_params }, 
            format: :json

          updated_item = RecurringItem.find(@recurring_item.id)
          expect(updated_item.amount).to eq(@recurring_item.amount)
        end

        it 'returns a json response' do
          put :update, 
            params: { id: @recurring_item.id, item: bad_params }, 
            format: :json

          expect(response.header['Content-Type']).to include 'application/json'
        end

        it 'returns a bad request status code' do
          put :update, 
            params: { id: @recurring_item.id, item: bad_params }, 
            format: :json

          expect(response).to have_http_status(400)
        end
      end
    end
  end

  describe 'GET #show' do
    before(:each) do 
      @recurring_item = FactoryBot.create(:recurring_item, user_id: @user.id)
    end

    after(:each) do
      @recurring_item.destroy
    end

    context 'given no one is logged in' do
      before do
        session[:session_token] = nil
      end

      it 'returns a json response' do
        get :show, params: { id: @recurring_item.id }, format: :json
        expect(response.header['Content-Type']).to include 'application/json'
      end
      
      it 'returns a 403 status code' do
        get :show, params: { id: @recurring_item.id }, format: :json
        expect(response).to have_http_status(403)
      end
    end

    context 'given the wrong user is logged in' do
      before do
        session[:session_token] = @wrong_user.session_token
      end

      after do 
        session[:session_token] = nil
      end

      it 'returns a json response' do
        get :show, params: { id: @recurring_item.id }, format: :json
        expect(response.header['Content-Type']).to include 'application/json'
      end
      
      it 'returns a 403 status code' do
        get :show, params: { id: @recurring_item.id }, format: :json
        expect(response).to have_http_status(403)
      end
    end

    context 'given the owner is logged in' do
      before do
        session[:session_token] = @user.session_token
      end

      after do 
        session[:session_token] = nil
      end

      context 'given a valid id' do
        it 'returns the item as json' do
          get :show, params: { id: @recurring_item.id }, format: :json
          expect(response).to render_template(:show)
        end
      end

      context 'given an invalid id' do
        it 'returns a json response' do
          get :show, params: { id: -1 }, format: :json
          expect(response.header['Content-Type']).to include 'application/json'
        end
      end
    end
  end

  describe 'GET #index' do
    context 'given no one is logged in' do
      before do
        session[:session_token] = nil
      end

      it 'returns a json response' do
        get :index, params: { user_id: @user.id }, format: :json
        expect(response.header['Content-Type']).to include 'application/json'
      end
      
      it 'returns a 403 status code' do
        get :index, params: { user_id: @user.id }, format: :json
        expect(response).to have_http_status(403)
      end
    end

    context 'given the wrong user is logged in' do
      before do
        session[:session_token] = @wrong_user.session_token
      end

      after do 
        session[:session_token] = nil
      end

      it 'returns a json response' do
        get :index, params: { user_id: @user.id }, format: :json
        expect(response.header['Content-Type']).to include 'application/json'
      end
      
      it 'returns a 403 status code' do
        get :index, params: { user_id: @user.id }, format: :json
        expect(response).to have_http_status(403)
      end
    end

    context 'given the owner is logged in' do
      before do
        session[:session_token] = @user.session_token
      end

      after do 
        session[:session_token] = nil
      end

      context 'given a valid user id' do
        it 'returns an index of all the user\'s recurring items' do
          get :index, params: { user_id: @user.id }, format: :json
          expect(response).to render_template(:index)
        end
      end
    end
  end
end
