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

  namespace :api, path: '/api', defaults: { format: :json } do
    namespace :v1 do
      post 'investor/type', to: 'investors#set_role'
      post 'investor/accreditation', to: 'investors#accreditation'
      get 'investor', to: 'investors#show'
      get 'philosophy', to: 'investment_philosophies#philosophy_question'
      post 'philosophy', to: 'investment_philosophies#philosophy'
    end
  end
end
