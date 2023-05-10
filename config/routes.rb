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

  post 'investor/type', to: 'investors#set_role'
  post 'investor/accreditation', to: 'investors#accreditation'
  get '/current_user', to: 'current_user#index'
end
