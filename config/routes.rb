Rails.application.routes.draw do
  resources :sessions, only: [:index, :create, :destroy]
  resources :users

  resources :pictures do
    collection do
      post :confirm
    end
  end
end
