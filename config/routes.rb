Rails.application.routes.draw do
  
  resources :donation_items
  
  get '/' => 'pages#index'
  get '/specials' => 'pages#specials'

  get '/orders/new' => 'orders#new'
	post '/orders' => 'orders#create'
	get '/orders/:id' => 'orders#show'

	get '/carted_donation_items' => 'carted_donation_items#index'
	post '/carted_donation_items' => 'carted_donation_items#create'
	delete '/carted_donation_items/:id' => 'carted_donation_items#destroy'

	get '/posts' => 'posts#index'
	get '/posts/new' => 'posts#new'
	post '/posts' => 'posts#create'
	get '/posts/:id' => 'posts#show'
 	
end
