Rails.application.routes.draw do
  devise_for :users
  root 'components#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  mount Api => "/"
  # Defines the root path route ("/")
  # root "articles#index"
end
