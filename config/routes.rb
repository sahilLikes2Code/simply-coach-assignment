# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root 'tasks#index'

  get '/sign_up', to: 'registrations#new'
  post '/sign_up', to: 'registrations#create'

  resources :tasks, only: :index
end
