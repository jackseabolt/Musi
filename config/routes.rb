Rails.application.routes.draw do
  resources :posts
  resources :profiles do 
  	member do 
  		get :myprofile
  	end 
  end 

  root 'profiles#index'
  
  devise_for :users, 
  :controllers => {
                :registrations => "client/registrations"
            }
  resources :users

  resources :conversations do
  	resources :messages
  end 
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
