# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root to: redirect('/tasks')

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/sign_up', to: 'registrations#new'
  post '/sign_up', to: 'registrations#create'

  resources :tasks, except: :show
end
