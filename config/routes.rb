Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :feeds
  get 'me', to: 'profile#me'
  get 'ping', to: 'ping#health_check'
end
