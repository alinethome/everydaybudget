Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'static_pages#index'

  namespace :api, defaults: { format: :json } do
    resources :users, only: [:create, :update, :destroy, :show]
    resources :recurring_items, except: [:new, :edit]
    resources :non_recurring_items, except: [:new, :edit]
    resource :session, only: [:create, :destroy]
    resource :budget, only: [:show]
  end
end
