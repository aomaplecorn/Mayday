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
    get 'users/mypage' => 'users#show', as: 'mypage'
    get 'users/edit' => 'users#edit', as: 'edit_mypage'
    patch 'users' => 'users#update'
    get 'users/check' => 'users#check', as: 'check'
    patch 'users/withdraw' => 'users#withdraw'

# artist_mypage GET             /artist/users/mypage(.:format)      artist/users#show
# artist_edit_mypage GET        /artist/users/edit(.:format)        artist/users#edit
# artist_users PATCH            /artist/users(.:format)             artist/users#update
# artist_check GET              /artist/users/check(.:format)       artist/users#check
# artist_users_withdraw PATCH   /artist/users/withdraw(.:format)    artist/users#withdraw

  end




end


