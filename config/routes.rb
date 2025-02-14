Rails.application.routes.draw do
  get 'posts/index'

  # TODO work on second nav bar highlighting

  root "users#new"
  resources :users, except: [:destroy, :edit, :update] do
    resources :profiles , only: [:create, :destroy, :edit, :update]
    resources :posts, except: [:new, :show]
    resources :friends, only: [:index]
    resources :photos, except: [:edit, :update]
  end

  get "user/:id/timeline" => "users#index"
  resources :search, only: [:index]
  resources :likes, only: [:create,:destroy]
  resources :comments, only: [:create,:destroy]
  resources :friends, only: [:create,:destroy]
  

 

  resource :session, :only => [:create, :destroy]
  post "login" => "session#create"
  delete "logout" => "session#destroy"
end
