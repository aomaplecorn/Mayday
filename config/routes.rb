Rails.application.routes.draw do

  root to: 'homes#top'

  # 以下、ユーザー認証(devise)
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: 'admin/sessions'
  }
  devise_for :customer,skip: [:passwords], controllers: {
    registrations: 'customer/registrations',
    sessions: 'customer/sessions'
  }
  devise_for :artist,skip: [:passwords], controllers: {
    registrations: 'artist/registrations',
    sessions: 'artist/sessions'
  }
  # ここまで、ユーザー認証(devise)

  # 以下、ゲストログインまとめ
    # アドミン
  devise_scope :admin do
    post 'admins/guest_sign_in', to: 'admin/sessions#new_guest'
  end
    # アーティスト
  devise_scope :artist do
    post 'artists/guest_sign_in', to: 'artist/sessions#new_guest'
  end
    # カスタマー
  devise_scope :customer do
    post 'customers/guest_sign_in', to: 'customer/sessions#new_guest'
  end
  # ここまで、ゲストログインまとめ

## 以下、アドミン
  namespace :admin, path:"" do
    get 'users' => 'users#index'
    patch 'artist_user/:id' => 'users#artist_update', as: 'artist_user'
    patch 'customer_user/:id' => 'users#customer_update', as: 'customer_user'
  end
## ここまで、アドミン

## 以下、アーティスト
  namespace :artist do
  # ユーザー
    get 'users/mypage' => 'users#show', as: 'mypage'
    get 'users/edit' => 'users#edit', as: 'edit_mypage'
    patch 'users' => 'users#update'
    get 'users/check' => 'users#check', as: 'check'
    patch 'users/withdraw' => 'users#withdraw'
  # アルバム
    resources :albums
  # 音楽
    resources :musics, only: [:create,:update,:destroy]
  # グッズ
    resources :items, except: [:show]
  end
## ここまで、アーティスト

## 以下、カスタマー
  namespace :customer do
  # ユーザー
    get 'users/mypage' => 'users#show', as: 'mypage'
    get 'users/edit' => 'users#edit', as: 'edit_mypage'
    patch 'users' => 'users#update'
    get 'users/check' => 'users#check', as: 'check'
    patch 'users/withdraw' => 'users#withdraw'
  # アイテム
    resources :items, only: [:index,:show]
  # カートアイテム
    delete 'cart_items/destroy_all' => 'cart_items#destroy_all'
    resources :cart_items, only: [:index, :create, :update, :destroy]
  # オーダー
    resources :orders, only: [:new,:create,:index,:show]
    get 'orders/complete' => 'orders#complete', as: 'order_complete'
    post 'orders/confirm' => 'orders#confirm', as: 'order_confirm'

# customer_orders GET       /customer/orders(.:format)                customer/orders#index
# POST                      /customer/orders(.:format)                customer/orders#create
# new_customer_order GET    /customer/orders/new(.:format)            customer/orders#new
# customer_order GET        /customer/orders/:id(.:format)            customer/orders#show
# customer_complete GET     /customer/orders/complete(.:format)       customer/orders#complete
# customer_confirm POST     /customer/orders/confirm(.:format)        customer/orders#confirm

  end
## ここまで、カスタマー


end


