Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations', confirmations: 'users/confirmations',
                                    omniauth_callbacks: 'users/omniauth_callbacks' }

  get 'home/index'

  root 'home#index'

  resources :users, only: [] do
    collection do
      get :homepage
    end
  end

  resources :user_targets, only: :index
end
