Ratemylandlord::Application.routes.draw do
  resources :landlords #TODO Limit this resource
  resources :ratings   #TODO Limit this resource

  get 'auth/:provider/callback', :to => 'sessions#create'
  get 'auth/failure', :to => redirect('/')
  get 'signout', :to => 'sessions#destroy', :as => 'signout'
  get 'signin', :to => 'sessions#signin', :as => 'signin'

  get '/admin' => 'admin#index', :as => 'admin'
  get '/revoke' => 'admin#revoke', :as => 'revoke_admin'
  post '/make' => 'admin#make', :as => 'make_admin'

  get '/about' => 'about#index', :as => 'about'
  post '/about' => 'about#update'
  match '/about/edit' => 'about#edit', :as => 'edit_about'
  get '/contact' => 'contact#index', :as => 'contact'
  post '/contact' => 'contact#update'
  match '/contact/edit' => 'contact#edit', :as => 'edit_contact'

  root :to => 'welcome#index'
end
