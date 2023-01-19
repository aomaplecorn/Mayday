Rails.application.routes.draw do

  devise_for :customers
  devise_for :artists
  root to: 'homes#top'
  # root to: '/'

  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
  }


end
