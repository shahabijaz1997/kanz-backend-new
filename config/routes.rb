Rails.application.routes.draw do

  devise_for :users, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    registration: 'signup'
  },
  controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    confirmations: 'users/confirmations'
  }

  namespace :v1, path: '/1.0', defaults: { format: :json } do
    post 'investor/type', to: 'investors#set_role'
    post 'investor/accreditation', to: 'investors#accreditation'
    get 'investor', to: 'investors#show'
    get 'philosophy', to: 'investment_philosophies#philosophy_question'
    post 'philosophy', to: 'investment_philosophies#philosophy'

    resources :attachments, except: :index
  end
end
