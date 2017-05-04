require 'api_constraints'

Rails.application.routes.draw do
  root 'web/reports#index'


  devise_for :users, constraints: {format: :html}, controllers: { registrations: "web/registrations" }
  as :user do
    get 'login', to: 'devise/sessions#new'
    post 'login', to: 'devise/sessions#create'
    delete 'logout', to: 'devise/sessions#destroy'

    get 'sign_up', to: 'web/registrations#new'
    get 'cancel',  to: 'web/registrations#cancel'
  end

  namespace :web, defaults: {format: :html}, constraints: {format: :html}, path: '/' do
    root 'reports#index'
    resources :votes,       constraints: {format: :html}
    resources :reports,     constraints: {format: :html}
    resources :issues,      constraints: {format: :html}
    resources :departments, constraints: {format: :html}
    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    resources :users, only: [:index, :show]
  end  


  namespace :api, defaults: {format: :json}, constraints: {format: :json}, path: '/api' do
    scope module: :v1 do
  		resources :departments
      resources :issues
      resources :reports
      resources :sessions, only: [:create, :destroy]
      resources :users,    only: [:index, :show]
      resources :votes

    end
  end


end
