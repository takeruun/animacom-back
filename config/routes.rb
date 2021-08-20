Rails.application.routes.draw do
  namespace :v1 do
    namespace :users do
      mount_devise_token_auth_for 'User', at: 'auth', controllers: {
        sessions: 'v1/users/auth/sessions',
        registrations: 'v1/users/auth/registrations'
      }
      namespace :posts do
        namespace :reactions do
          namespace :bests do
            get '/cute' => 'cute/index#index'
            get '/fav'  => 'fav/index#index'
            get '/good' => 'good/index#index'
            get '/cool' => 'cool/index#index'
          end
          namespace :counts do
            get '/' => 'index#index'
          end
          get    '/'         => 'index#index'
          post   '/:post_id' => 'create#create'
          delete '/:id'      => 'destroy#destroy'
        end
        get    '/:id' => 'show#show'
        put    '/:id' => 'edit#edit'
        delete '/:id' => 'destroy#destroy'
        get     '/'   => 'index#index'
        post    '/'   => 'create#create'
      end
      namespace :follows do
        get '/'           => 'index#index'
        get '/followings' => 'index#followings'
        get '/followers'  => 'index#followers'
        post '/'          => 'create#create'
        delete '/'        => 'destroy#destroy'
      end
      get '/'         => 'index#index'
      get '/my_page'  => 'show#my_page'
      get '/:user_id' => 'show#show'
      put '/'         => 'update#update'
    end
    namespace :posts do
      namespace :search do
        get '/' => 'index#index'
      end
      namespace :reactions do
        namespace :bests do
          get '/cute' => 'cute/index#index'
          get '/fav' => 'fav/index#index'
          get '/good' => 'good/index#index'
          get '/cool' => 'cool/index#index'
        end
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
      get '/:post_id/comments' => 'comments/index#index'
    end
    namespace :categories do
      get '/' => 'index#index'
      namespace :root do
        get '/' => 'index#index'
      end
    end
  end
  mount ActionCable.server => '/v1/cable'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/health' => 'health#health'
end
