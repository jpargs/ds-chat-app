Rails.application.routes.draw do
  devise_for :users, :path => '', controllers: {sessions: 'sessions', registrations: 'registrations', :passwords => "passwords",}, path_names: { sign_in: '/', password: '/forgot', confirmation: '/confirm', unlock: '/unblock', registration: '/register', sign_up: '/sign_up', sign_out: '/logout'}
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  # Landing page
  root :to => 'login#index'
  
  get "sign_up", to: 'sign_up#index'
  resources :login
  resources :users
end
