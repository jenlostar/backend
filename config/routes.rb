Rails.application.routes.draw do

  use_doorkeeper
  concern :paginatable do
    get '(page/:page)', action: :index, on: :collection, as: ''
  end

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :places, only: [:index, :show]
      resources :bookings, only: [:create, :index]
      post 'login' => 'users#login', as: 'login'
      post 'logout' => 'users#logout', as: 'logout'
      post 'signup' => 'users#signup', as: 'signup'
    end
  end

  devise_for :admins

  resources :places, concerns: :paginatable do

    with_options except: [:index, :show] do |list_except|
      list_except.resources :schedules
      list_except.resources :services
    end

    get 'selected' => 'places#index', as: :selected, on: :member
  end

  resources :bookings, only: [:index] do
    member do
      post 'approve'
      post 'discard'
    end

    collection do
      get 'canceled' => 'bookings#canceled', as: :canceled
      get 'approved' => 'bookings#approved', as: :approved
    end
  end

  root 'places#index'
end
