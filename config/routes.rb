# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :admin_users

  devise_for :users, path: '', path_names: {
                                 sign_in: 'login',
                                 sign_out: 'logout',
                                 registration: 'signup'
                               },
                     controllers: {
                       sessions: 'users/sessions',
                       registrations: 'users/registrations'
                     }, skip: [:confirmations], skip_helpers: true

  resources :confirmations, controller: 'users/confirmations', only: [:update, :create]

  namespace :users do
    post 'social_auth/google', to: 'social_auth#google'
    post 'social_auth/linkedin', to: 'social_auth#linkedin'
    get 'social_auth/linkedin', to: 'social_auth#linkedin'
  end

  namespace :v1, path: '/1.0', defaults: { format: :json } do
    post 'investor/type', to: 'investors#set_role'
    post 'investor/accreditation', to: 'investors#accreditation'
    get 'investor', to: 'investors#show'
    resources :investment_philosophies, param: :step, only: %i[show create]
    resources :syndicates
    resources :startups
    resources :realtors
    resources :attachments, except: :index
    resources :countries, only: %i[index]
    resources :users, only: %i[show update]
    resources :industries, only: %i[show]
    get 'settings/attachments' => 'settings/attachments'
  end

  # Admin routes
  resources :admin_users
  resources :investors, only: %i[index show update]
  resources :realtors, only: %i[index show update]
  resources :startups, only: %i[index show update]
  resources :syndicates, only: %i[index show update]

  get "dashboard/index"  
  root to: "dashboard#index"
end
