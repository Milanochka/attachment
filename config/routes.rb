Rails.application.routes.draw do
  root 'items#index'
  resources :basket_items
  resources :items
  resources :basket
  post '/add_to_basket', to: 'basket#add_to_basket', as: 'add_item'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
