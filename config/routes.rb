Rails.application.routes.draw do
  
  resources :donation_items
  resources :specials
  
  get '/' => 'pages#index'

  get '/orders/new' => 'orders#new'
  get 'orders/cancel_recurring_charge_form' => 'orders#cancel_recurring_charge_form'
	post '/orders/cancel_recurring_charge' => 'orders#cancel_recurring_charge'
	post '/orders' => 'orders#create'
	get '/orders/:id' => 'orders#show'
	get '/recurring_charges' => 'orders#recurring_charges'


	get '/carted_donation_items' => 'carted_donation_items#index'
	post '/carted_donation_items' => 'carted_donation_items#create'
	delete '/carted_donation_items/:id' => 'carted_donation_items#destroy'

	get '/posts' => 'posts#index'
	get '/posts/new' => 'posts#new'
	post '/posts' => 'posts#create'
	get '/posts/:id' => 'posts#show'
 	
 	get '/login' => 'sessions#new'
	post '/login' => 'sessions#create'
	get '/logout' => 'sessions#destroy'

end
