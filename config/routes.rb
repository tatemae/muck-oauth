Rails.application.routes.draw do
  resources :oauth_clients
  match '/oauth/test_request' => 'oauth#test_request', :as => :test_request
  match '/oauth/access_token' => 'oauth#access_token', :as => :access_token
  match '/oauth/request_token' => 'oauth#request_token', :as => :request_token
  match '/oauth/authorize' => 'oauth#authorize', :as => :authorize
  match '/oauth' => 'oauth#index', :as => :oauth
  resources :oauth_consumers do
    member do
      get :callback
    end
  end
end