root to: 'home#login'
get '/home/index', to: 'home#index'

resources :users, only: [:new, :create]
get '/users/confirm/:token', to: 'users#confirm', as: :confirm_email
post '/users/update_order', to: 'users#update_order'

resources :sessions, only: [:new, :create, :destroy]

resources :lists, only: [:create, :destroy, :update] do
  collection do
    post 'update'
    post 'mark'
    post 'unmark'
  end
end

resources :items, only: [:create, :destroy] do
  collection do
    post 'mark'
    post 'unmark'
  end
end

resources :subitem, only: [:create, :destroy] do
  collection do
    post 'mark'
    post 'unmark'
  end
end

