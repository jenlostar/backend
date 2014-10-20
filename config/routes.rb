Rails.application.routes.draw do

  concern :paginatable do
    get '(page/:page)', action: :index, on: :collection, as: ''
  end

  devise_for :admins

  resources :places, concerns: :paginatable do

    with_options except: [:index, :show] do |list_except|
      list_except.resources :schedules
      list_except.resources :services
    end

    get 'selected' => 'places#index', as: :selected, on: :member
  end

  resources :bookings, only: [:index, :update]

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :places, only: [:index, :show]
      resources :bookings, only: [:create, :index]
    end
  end

  root 'places#index'
end
