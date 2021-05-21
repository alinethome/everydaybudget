Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'static_pages#index'

  namespace :api, defaults: { format: :json } do
    resources :users, only: [:create, :update, :destroy, :show] do
      resources :recurring_items, only: [:create, :index]
      resources :non_recurring_items, only: [:create, :index]
    end

    resources :recurring_items, only: [:update, :destroy, :show]
    resources :non_recurring_items, only: [:update, :destroy, :show]
    resource :session, only: [:create, :destroy]
    resource :budget, only: [:show]
  end
end
