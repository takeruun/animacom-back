Rails.application.routes.draw do
  namespace :v1 do
    namespace :users do
      mount_devise_token_auth_for 'User', at: 'auth', controllers: {
        sessions: 'v1/users/auth/sessions',
        registrations: 'v1/users/auth/registrations'
    }
    end
    namespace :posts do
      namespace :reactions do
        post '/:post_id' => 'create#create'
        delete '/:id' => 'destroy#destroy'
      end
      namespace :latest do
        get '/' => 'index#index'
      end
      namespace :day_ago do
        get '/' => 'index#index'
      end
      get '/:id' => 'show#show'
      put '/:id' => 'edit#edit'
      get '/'    => 'index#index'
      post '/'   => 'create#create'
      delete '/:id' => 'destroy#destroy'
    end
    namespace :categories do
      get '/' => 'index#index'
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/health' => 'health#health'
end
