MubookMonitor::Application.routes.draw do
  resources :records, only: [:index, :show, :create]

  root 'records#index'
end
