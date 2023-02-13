Rails.application.routes.draw do

  root to: 'homes#top'
  get '/search' => 'homes#search',as: 'search'
  get '/home' => 'homes#home', as: 'home'

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
    # ユーザー
    get 'users' => 'users#index'
    patch 'artist_user/:id' => 'users#artist_update', as: 'artist_user'
    patch 'customer_user/:id' => 'users#customer_update', as: 'customer_user'
    # プロダクト（音楽・グッズ全て）
    resources :products, only: [:index]
    get 'item/:id' => 'products#item_show', as: 'item'
    get 'album/:id' => 'products#album_show', as: 'album'
    delete 'item/:id' => 'products#item_destroy'
    delete 'album/:id' => 'products#album_destroy'
  end
## ここまで、アドミン

## 以下、アーティスト
  namespace :artist do
  # ユーザー
    resources :users, only: [:show,:edit,:update]
    get 'users/:id/check' => 'users#check', as: 'check'
    patch 'users/:id/withdraw' => 'users#withdraw', as: 'withdraw'
  # アルバム
    resources :albums
  # 音楽
    resources :musics, only: [:create,:update,:destroy]
  # グッズ
    resources :items, except: [:show]
  # 注文
    resources :orders, only: [:index,:show,:update]
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
    get 'orders/complete' => 'orders#complete', as: 'order_complete'
    resources :orders, only: [:new,:create,:index,:show]
    post 'orders/confirm' => 'orders#confirm', as: 'order_confirm'
    # アルバム（音楽関連）
    resources :albums, only: [:create,:index,:show]
  end
## ここまで、カスタマー



end


