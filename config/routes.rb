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
    resources :investment_philosophies, param: :step, only: %i[show create]
    resources :syndicates do
      collection do
        get :all
        get :deals
      end
      resources :syndicate_members, only: %i[index create destroy]
    end
    resources :syndicate_members, only: %i[index create destroy]
    resources :fund_raisers do
      collection do
        get :investors
      end
    end
    resources :investors, only: %i[index show] do
      post :accreditation
      post :investor_type
      collection do
        get :deals
      end
    end
    resources :attachments, except: :index do
      collection do
        post :submit
      end
      member do
        get :download
      end
    end
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
      collection do
        get :live
      end
      resources :invites do
        collection do
          post :syndicate_group
          post :request_syndication
        end
      end
      resources :comments
      resources :syndicates, only: %i[show index]
      resources :investments, only: %i[index create]
      resources :investors, only: %i[index]
    end
    resources :deals, param: :token, only: %i[show]
    post 'deals/:id/submit' => 'deals#submit'
    get 'deals/:id/review' => 'deals#review'
    get 'settings/attachments' => 'settings#attachments'
    get 'settings/stepper' => 'settings#stepper'
    get 'regions' => 'industries#regions'

    resources :users do
      resources :invites, only: %i[index]
      resources :investments, only: %i[index show revert]
    end
    get :check_session, to: 'users#check_session'
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
  resources :fund_raisers, only: %i[index show update]
  resources :syndicates, only: %i[index show update] do
    resources :syndicate_groups, only: %i[index create destroy]
  end
  resources :deals, only: %i[update] do
    collection do
      get :spv
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
  resources :field_attributes
  resources :steppers

  root to: "dashboard#index"
end
