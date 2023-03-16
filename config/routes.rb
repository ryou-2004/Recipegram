Rails.application.routes.draw do
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  devise_for :users
  root to: "home#index"
  resources :users do
    resource :relationships, only: %i[create destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
  end
  resources :recipes do
    resource :favorite, only: %i[create destroy]
    get 'like' => 'favorites#favousers', as: 'users'
  end
  get 'hashtags', to: 'hashtags#show'
  get 'hashtags/:hashtag', to: 'hashtags#show', as: 'search_route'
  post 'hashtags/', to: 'hashtags#search', as: 'search_post_route'
end
