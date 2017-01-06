Rails.application.routes.draw do

  devise_for :users
  # root 'welcome#index'


    root 'groups#index'
  resources :groups
  # 顺序无所谓的
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
