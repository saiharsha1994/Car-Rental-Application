Rails.application.routes.draw do

  resources :suggestions
  resources :reservations
    resources :cars

  get '/home',  to: 'homepage#home'
  root 'homepage#home'

  get '/login', to: 'session#new'
  post '/login', to: 'session#create'
  delete '/logout', to: 'session#destroy'

  post '/users/new', to: 'users#new'

  get '/user_manage_cars',  to: 'users#user_manage_cars'
  get '/admin_manage_cars',    to: 'users#admin_manage_cars'

  get '/search_car',  to: 'reservations#search_car'
  post '/search_car',  to: 'reservations#search'

  get '/selected_car_list',  to: 'reservations#selected_car_list'
  post '/selected_car_list',  to: 'reservations#selected_car_list'

  get '/reserve_car',  to: 'reservations#reserve_car'
  post '/reserve_car',  to: 'reservations#reserve'

  get '/notify_car',  to: 'reservations#notify_car'
  post '/notify_car',  to: 'reservations#notify_car'

  get '/reserve_final',  to: 'reservations#reserve_final'
  post '/reserve_final',  to: 'reservations#reserve_final'

  get '/reserve_checkout',  to: 'reservations#checkout'
  post '/reserve_checkout',  to: 'reservations#checkout'

  get '/reserve_return',  to: 'reservations#return'
  post '/reserve_return',  to: 'reservations#return'

  get '/reserve_cancel',  to: 'reservations#cancel'
  post '/reserve_cancel',  to: 'reservations#cancel'

  get '/view_car_history',  to: 'cars#view_car_history'
  post '/view_car_history',  to: 'cars#view_car_history'

  get '/manage_reservation',  to: 'reservations#manage_reservation'
  post '/manage_reservation',  to: 'reservations#manage_reservation_list'

  get '/view_admins',  to: 'users#view_admins'
  get '/view_superadmins',  to: 'users#view_superadmins'

  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
