Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users
  resources :dogs
  #member do
  #  post 'toggle_favorite', to: "dogs#toggle_favorite"
  #end
#end


  root to: "dogs#index"
end
