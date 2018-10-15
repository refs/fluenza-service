# -*- encoding : utf-8 -*-

Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  # root to: "accounts#index"
  root to: redirect('index.html')

  devise_for :users, controllers: {sessions: 'users/sessions', registrations: 'users/registrations'} do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  devise_for :agencies, controllers: {sessions: 'agencies/sessions', registrations: 'agencies/registrations'} do
    get '/agencies/sign_out' => 'devise/sessions#destroy'
  end

  get "profile", to: "users#profile"
  post "follow", to: "influencers#follow"
  post "unfollow", to: "influencers#unfollow"

  resources :accounts do
    get '/accounts/external_search' => 'accounts#index_youtube_account'
  end

  resources :users do
    resources :accounts
    resources :campaigns
  end

  resources :influencers, only: [:index, :show] do
    resources :videos
    resources :posts
    post 'refresh_snapshots', on: :member
  end

  resources :user_media_contents, only: [:update]
  namespace :admin do
    resources :users
  end

  namespace :graphs do
    resources :influencers do
      get 'youtube_subscribers', on: :member
      get 'youtube_views', on: :member
      get 'instagram_followers', on: :member
      get 'instagram_likes', on: :member
    end
    resources :videos do
      get 'views_fluctuation', on: :member
      get 'likes_fluctuation', on: :member
    end
    resources :posts do
      get 'likes_fluctuation', on: :member
    end
    resources :campaigns do
      get 'youtube_views', on: :member
      get 'posts_likes', on: :member
    end
  end

  namespace :v1 do
    resources :users, only: [:create, :show]
  end

  get '/youtube_categories', to: 'youtube_categories#index'
  get '/oauth/youtube_callback' => 'oauth/call_backs#youtube_handler'
  get '/oauth/instagram_callback' => 'oauth/call_backs#instagram_handler'

  require 'sidekiq/web'
  mount Sidekiq::Web => 'sidekiq'

  Sidekiq::Web.use Rack::Auth::Basic do |username, password|
    username == 'admin' && password == 'bonsai'
  end unless Rails.env.development?
end
