# frozen_string_literal: true

Rails.application.routes.draw do
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

  namespace :v1, path: '/1.0', defaults: { format: :json } do
    post 'investor/type', to: 'investors#set_role'
    post 'investor/accreditation', to: 'investors#accreditation'
    get 'investor', to: 'investors#show'
    resources :investment_philosophies, param: :step, only: %i[show create]
    resources :syndicates
    resources :attachments, except: :index
    resources :countries, only: %i[index]
  end
end
