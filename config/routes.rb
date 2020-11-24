Rails.application.routes.draw do
  devise_for :users
  root 'pages#home'
  get 'like_article', to: 'articles#like'
  resources :articles
  resources :categories
  resources :users, except: [:new]
  get '/users/:id/likes', to: 'users#likes'
end
