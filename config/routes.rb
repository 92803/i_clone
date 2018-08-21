Rails.application.routes.draw do
  root 'sessions#index'
  resources :sessions, only: [:index, :create, :destroy]
  resources :users

  resources :pictures do
    collection do
      post :confirm
    end
  end
end
