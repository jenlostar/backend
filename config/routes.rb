Rails.application.routes.draw do

  concern :paginatable do
    get '(page/:page)', action: :index, on: :collection, as: ''
  end

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      devise_for :users, skip: [:sessions, :registrations, :passwords]

      devise_scope :user do
        post '/login', to: 'sessions#create'
        delete '/logout', to: 'sessions#destroy'
        post '/signup', to: 'registrations#create'
      end

      resources :places, only: [:index, :show]
      resources :bookings, only: [:create, :index]
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
