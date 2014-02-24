MubookMonitor::Application.routes.draw do
  get "users/new"
  get "users/update"
  get "sessions/new"

  resources :records, only: [:index, :show]

  post 'api/records',    to: 'records#create'
  post 'api/testing',    to: 'records#testing'
  post 'api/production', to: 'records#production'

  root 'records#index'
end
