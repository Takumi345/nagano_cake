Rails.application.routes.draw do

  # 顧客用
  # URL /customers/sign_in ...
  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  root to: "homes#top"
  get '/admin', to: 'admin/homes#top'
  get  '/home/about', to: 'homes#about', as: 'about'


  namespace :admin do
    resources :genre, only: [:index, :create, :edit, :update]
    resources :orders_detail, only: [:update]
    resources :orders, only: [:show, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :items, only: [:index, :new, :create, :show, :edit, :update]
    resources :homes, only: [:top]
  end

  namespace :public do
    post 'orders/confirm'
    get 'orders/complete'
    delete 'cart_items/destroy_all'
    get 'customers/confirm'
    patch 'customers/withdraw'
    resources :addresses, only: [:index, :create, :edit, :update, :destroy]
    resources :orders, only: [:new, :create, :index, :show]
    resources :cart_items, only: [:index, :create, :destroy, :update]
    resource :customers, only: [:show, :edit, :update]
    resources :items, only: [:index, :show]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
