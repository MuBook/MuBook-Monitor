MubookMonitor::Application.routes.draw do
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy'

  get 'signup', to: 'users#new'
  post 'signup', to: 'users#create'

  resources :records, only: [:index, :show]

  post 'api/records',    to: 'records#create'
  post 'api/testing',    to: 'records#testing'
  post 'api/production', to: 'records#production'

  root 'records#index'
end
