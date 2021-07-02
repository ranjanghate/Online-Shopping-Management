Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "home#index"
  get "home", to: "home#index"
  devise_for :users

  resources :users, only: :index do
    resources :addresses, only: %i(index new create edit update destroy) do
      post :set_primary_address, on: :member
    end

    resources :purchases, only: %i(index create) do
      get :bill, on: :collection
      resources :purchase_items, only: %i(index)
    end
  
    resources :cart_items, only: %i(index destroy)

    member do
      get :edit_password
      patch :update_password
    end
  end

  resources :courses do
    resources :cart_items, only: %i(create)
  end
end
