root to: 'home#login' 
get '/home/index', to: 'home#index'

resources :users, only: [:new, :create] do
  member do
    # get 'confirm/:token', to: 'users#confirm', as: :confirm_email
  end
end

resources :sessions, only: [:new, :create, :destroy]

resources :lists, only: [:create, :destroy, :update]

get '/users/confirm/:token', to: 'users#confirm', as: :confirm_email

post '/items', to: 'items#create'
post '/lists', to: 'lists#create'
post '/items/delete', to: 'items#delete'
post '/lists/delete', to: 'lists#delete'
get '/items/mark', to: 'items#mark'
post '/items/mark', to: 'items#mark'
get '/items/unmark', to: 'items#unmark'
post '/items/unmark', to: 'items#unmark'
post '/subitem', to: 'subitem#create'
get '/lists/rename', to: 'lists#rename'
post '/lists/rename', to: 'lists#rename'
get '/subitem/mark', to: 'subitem#mark'
post '/subitem/mark', to: 'subitem#mark'
get '/subitem/unmark', to: 'subitem#unmark'
post '/subitem/unmark', to: 'subitem#unmark'
get '/subitem/delete', to: 'subitem#delete'
post '/subitem/delete', to: 'subitem#delete'
