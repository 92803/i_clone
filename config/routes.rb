Rails.application.routes.draw do
  root 'sessions#index'
  resources :sessions
  resources :users
  resources :favorites
  resources :pictures do
    collection do
      post :confirm
    end
  end

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at:"/letter_opener"
  end
end
