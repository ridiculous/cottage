Rails.application.routes.draw do
  root to: 'home#index'
  post 'calendar/create'

  resources :reservations
  resources :contacts

  resources :home, only: :index do
    collection { get :photos }
  end
end
