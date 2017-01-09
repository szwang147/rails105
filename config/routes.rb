Rails.application.routes.draw do

  devise_for :users
  # root 'welcome#index'


  resources :groups do
    member do
      post :join
      post :quit
    end

    resources :posts
  end
  root 'groups#index'

  namespace :account do
    resources :groups
    resources :posts
  end
  # 顺序无所谓的
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
