MubookMonitor::Application.routes.draw do
  resources :records, only: [:index, :show]

  post 'api/records',    to: 'records#create'
  post 'api/testing',    to: 'records#testing'
  post 'api/production', to: 'records#production'

  root 'records#index'
end
