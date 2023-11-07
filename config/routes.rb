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
    resources :property_owners
    resources :attachments, except: :index
    resources :countries, only: %i[index]
    resources :users, only: %i[show update]
    resources :industries, only: %i[index]
    resources :deals, except: %i[show] do
      member do
        get :overview
        get :documents
        get :comments
        get :activities
        post :sign_off
        get :unique_selling_points
      end
      resources :invites
      resources :comments
      resources :syndicates, only: %i[show index]
    end
    resources :deals, param: :token, only: %i[show]
    post 'deals/:id/submit' => 'deals#submit'
    get 'deals/:id/review' => 'deals#review'
    get 'settings/attachments' => 'settings#attachments'
    get 'settings/stepper' => 'settings#stepper'
    get 'regions' => 'industries#regions'
    post 'attachments/submit', to: 'attachments#submit'

    resources :users do
      resources :invites, only: %i[index]
    end
    resources :invitees, model_name: 'User' do
      resources :invites, only: %i[index]
    end
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
  resources :property_owners, only: %i[index show update]
  resources :startups, only: %i[index show update]
  resources :syndicates, only: %i[index show update]
  resources :deals, only: %i[update] do
    collection do
      resources :start_up, only: %i[index show], controller: 'deals', type: 'start_up'
      resources :property, only: %i[index show], controller: 'deals', type: 'property'
    end
  end
  resources :profile, only: %i[index] do
    collection do
      get :edit
      put :update
    end
  end
  resources :dashboard, only: %i[index]

  root to: "dashboard#index"
end
