Rails.application.routes.draw do
  root 'sessions#index'
  resources :sessions, only: [:index, :create, :destroy]
  resources :users
  resources :favorites, only: [:create, :destroy]
  resources :pictures do
    collection do
      post :confirm
    end
  end

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at:"/letter_opener"
  end
end
