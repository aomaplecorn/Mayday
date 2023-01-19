Rails.application.routes.draw do


  namespace :admin, path:"" do
    resources :users, only: [:index,:update]
# admin_users GET    /admin/users(.:format)        admin/users#index
# admin_user PATCH  /admin/users/:id(.:format)     admin/users#update
# PUT    /admin/users/:id(.:format)                admin/users#update

  # get 'users' => 'users#index'
  # patch 'users/:id' => 'users#update', as: 'update_admin_user'
# admin_users_index GET    /users/index(.:format)  admin/users#index

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


