FrontEnd::Application.routes.draw do

  get 'dashboard' => 'dashboard#show'
  get 'cupboard' => 'dashboard#cupboard'
  get 'recipe' => 'dashboard#recipe'
  get 'login' => 'dashboard#login'
  get 'shopping-list' => 'dashboard#shopping_list', as: 'shopping_list'
  get 'logout' => 'dashboard#logout'
  post  'list' => 'dashboard#list'
  post 'populate_cupboard' => 'dashboard#populate_cupboard'
  post 'update_quantity/:id' => 'dashboard#update_quantity', as: 'update_quantity'
  match 'destroy-list-item' => 'dashboard#destroy_list_item', as: 'destroy_list_item', via: [:delete]
  delete 'drop_from_cupboard/:id' => 'dashboard#drop_from_cupboard', as: 'drop_from_cupboard'

  match 'hostess' => redirect('http://fridge-hostess.herokuapp.com/auth/facebook'),via: [:post, :get]
  get 'auth/hostess/callback' => 'dashboard#show'

  root to: 'dashboard#show'

end
