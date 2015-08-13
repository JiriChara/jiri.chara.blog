JiriCharaBlog::Application.routes.draw do
  # API
  namespace :api, path: '/', constraints: { subdomain: 'api' }, defaults: { format: 'json' } do
    root to: 'home#index'

    resources :me, only: [:index]

    resources :articles, only: [:index, :show, :create, :destroy] do
      resources :comments, only: [:index, :create]
    end

    resource :comments, only: [:destroy, :show] do
      resource :karmas, only: [:index, :destroy, :create]
    end

    resources :users, only: [:index, :show, :create] do
      resources :comments, only: [:index]
    end

    match '*unmatched_route', to: 'errors#raise_not_found!', via: :all
  end

  root to: 'application#home'
  get '*path' => 'application#home'
end
