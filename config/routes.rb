JiriCharaBlog::Application.routes.draw do
  root to: 'articles#index'

  resources :users do
    member do
      patch :ban
      patch :unban
    end
  end

  resources :comments

  resources :images, only: [:index, :create, :destroy]

  resources :karmas, only: [:create, :destroy]

  # Static pages
  get '/about', to: 'static_pages#about'
  get '/cv',    to: 'static_pages#cv'
  get '/oops',  to: 'static_pages#oops'

  match '/auth/:provider/callback', to: 'sessions#create', via: [:post, :get]
  get '/signout', to: 'sessions#destroy', as: 'signout'
  get '/signin', to: 'sessions#new', as: 'signin'
  # match '/auth/failure', to: 'articles#index'

  get '/admin', to: 'admin#index'

  resources :articles, only: [:new, :create] do
    member do
      patch :publish
      patch :unpublish
    end

    collection do
      get :unpublished
    end
  end
  resources :articles, except: [:index, :new, :create], path: ""
end
