Rails.application.routes.draw do

  root to: 'homes#top'

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

  namespace :admin, path:"" do
    get 'users' => 'users#index'
    patch 'artist_user/:id' => 'users#artist_update', as: 'artist_user'
    patch 'customer_user/:id' => 'users#customer_update', as: 'customer_user'
  end

  namespace :artist do
  # 以下、ユーザー
    get 'users/mypage' => 'users#show', as: 'mypage'
    get 'users/edit' => 'users#edit', as: 'edit_mypage'
    patch 'users' => 'users#update'
    get 'users/check' => 'users#check', as: 'check'
    patch 'users/withdraw' => 'users#withdraw'

  # 以下、アルバム
    resources :albums
# artist_albums GET       /artist/albums(.:format)               artist/albums#index
# POST                    /artist/albums(.:format)               artist/albums#create
# new_artist_album GET    /artist/albums/new(.:format)           artist/albums#new
# edit_artist_album GET   /artist/albums/:id/edit(.:format)      artist/albums#edit
# artist_album GET        /artist/albums/:id(.:format)           artist/albums#show
# PATCH                   /artist/albums/:id(.:format)           artist/albums#update
# PUT                     /artist/albums/:id(.:format)           artist/albums#update
# DELETE                  /artist/albums/:id(.:format)           artist/albums#destroy

  # 以下、音楽
    resources :musics, except: [:show]

  end




end


