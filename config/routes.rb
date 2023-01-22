Rails.application.routes.draw do


  namespace :admin, path:"" do
    # resources :users, only: [:index,:update]
# admin_users GET    /admin/users(.:format)        admin/users#index
# admin_user PATCH  /admin/users/:id(.:format)     admin/users#update
# PUT    /admin/users/:id(.:format)                admin/users#update

  get 'users' => 'users#index'
  patch 'artist_user/:id' => 'users#artist_update', as: 'artist_user'
  patch 'customer_user/:id' => 'users#customer_update', as: 'customer_user'
# admin_users GET    /users(.:format)              admin/users#index
# admin_update_user PATCH  /users/:id(.:format)    admin/users#update

# admin_artist_user PATCH  /artist_users/:id(.:format)         admin/users#update
# admin_customer_user PATCH  /customer_users/:id(.:format)     admin/users#update

  end

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

end


