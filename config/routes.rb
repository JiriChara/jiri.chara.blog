JiriCharaBlog::Application.routes.draw do
  # API
  namespace :api, path: '/', constraints: { subdomain: 'api' }, defaults: { format: 'json' } do
    root to: 'home#index'

    resources :articles, only: [:index, :show, :create, :destroy] do
      resources :comments, only: [:index]
    end

    resources :users, only: [:index, :show, :create] do
      resources :comments, only: [:index]
    end

    match '*unmatched_route', to: 'errors#raise_not_found!', via: :all
  end

  scope constraints: { subdomain: '' } do
    root to: 'articles#index'

    resources :users do
      member do
        patch :ban
        patch :unban
      end
    end

    resources :comments

    resources :images, only: [:index, :create, :destroy]

    resources :karmas, only: [:create]

    # Static pages
    get '/about', to: 'static_pages#about'
    get '/cv',    to: 'static_pages#cv'
    get '/oops',  to: 'static_pages#oops'

    match '/auth/:provider/callback', to: 'sessions#create', via: [:post, :get]
    get '/auth/failure', to: 'sessions#failure'
    delete '/signout', to: 'sessions#destroy', as: 'signout'
    get '/signin', to: 'sessions#new', as: 'signin'

    get '/admin', to: 'admin#index'
    get '/admin/access_info', to: 'admin#access_info'

    resources :articles, only: [:new, :create] do
      member do
        patch :publish
        patch :unpublish
      end

      collection do
        get :unpublished
      end
    end

    resources :tags

    resources :articles, except: [:index, :new, :create], path: "" do
      resources :images
    end

    match '*unmatched_route', to: 'errors#raise_not_found!', via: :all
  end
end
