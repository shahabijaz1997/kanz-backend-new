# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :admin_users,
    controllers: {
      passwords: 'admin_users/passwords',
      sessions: 'admin_users/sessions'
    }

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
    resources :industries, only: %i[index]
    resources :deals
    get 'settings/attachments' => 'settings#attachments'
    get 'settings/stepper' => 'settings#stepper'
    get 'regions' => 'industries#regions'
    post 'attachments/submit', to: 'attachments#submit'
  end

  # Admin routes
  resources :admin_users do
    get :reactivate, on: :member
  end
  resources :investors, only: %i[update] do
    collection do
      resources :individuals, only: %i[index show], controller: 'investors', type: 'individuals'
      resources :firms, only: %i[index show], controller: 'investors', type: 'firms'
    end
  end
  resources :realtors, only: %i[index show update]
  resources :startups, only: %i[index show update]
  resources :syndicates, only: %i[index show update]
  resources :stepper, only: %i[index new create edit update]
  resources :profile, only: %i[index] do
    collection do
      get :edit
      put :update
    end
  end
  resources :dashboard, only: %i[index]

  root to: "dashboard#index"
end
