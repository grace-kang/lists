root to: 'home#login'
get '/home/index', to: 'home#index'

resources :users, only: [:new, :create]
get '/users/confirm/:token', to: 'users#confirm', as: :confirm_email
post '/users/update_order', to: 'users#update_order'
get '/users/forgot_pass', to: 'users#forgot_pass'
get '/users/new_pass/:token', to: 'users#new_pass', as: :new_pass
get '/users/update_pass', to: 'users#update_pass'
get '/users/send_recovery', to: 'users#send_recovery'

resources :sessions, only: [:new, :create, :destroy]

resources :lists, only: [:create, :destroy, :update] do
  collection do
    post 'update'
    post 'mark'
    post 'unmark'
  end
end
post '/lists/update_order', to: 'lists#update_order'

resources :items, only: [:create, :destroy] do
  collection do
    post 'mark'
    post 'unmark'
  end
end
post '/items/update_order', to: 'items#update_order'

resources :subitem, only: [:create, :destroy] do
  collection do
    post 'mark'
    post 'unmark'
  end
end

