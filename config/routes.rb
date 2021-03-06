Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations', confirmations: 'users/confirmations',
                                    omniauth_callbacks: 'users/omniauth_callbacks', passwords: 'users/passwords' }

  get 'home/index'

  root 'home#index'

  resources :users, only: [:update] do
    collection do
      get :homepage
    end
  end

  resources :user_targets, only: %i(create index show destroy)

  resources :chats, only: :show do
    member do
      post :read_messages
    end
  end

  resources :messages, only: :create

  mount ActionCable.server => '/cable'
end
