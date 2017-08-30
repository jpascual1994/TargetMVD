Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations', confirmations: 'users/confirmations' }

  get 'home/index'

  root 'home#index'

  resources :users, only: [] do
    collection do
      get :homepage
    end
  end
end
