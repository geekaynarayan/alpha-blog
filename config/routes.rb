Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'pages#index'

  resources :articles

  get 'signup', to: 'users#new'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'delete', to: 'sessions#destroy', as: 'logout'

  resources :users, except: [:new]

resources :categories, except: [:destroy]

end
