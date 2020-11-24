Rails.application.routes.draw do
  root 'pages#home'
  get 'signup', to: 'users#new'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  get 'like_article', to: 'articles#like'
  resources :articles
  resources :categories
  resources :users, except: [:new]
  get '/users/:id/likes', to: 'users#likes'
end
