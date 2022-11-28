# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :articles, only: %i[index]
  resources :registrations, only: %i[new create]
  resources :sessions, only: %i[new create] do
    delete :destroy, on: :collection
  end
  resources :likes, only: %i[create destroy]

  # Defines the root path route ("/")
  root 'home#index'
end
