Rails.application.routes.draw do
  resources :donation_items
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/' => 'pages#index'
 	
end
