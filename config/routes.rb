FrontEnd::Application.routes.draw do

  get 'dashboard' => 'dashboard#show'
  get 'cupboard' => 'dashboard#cupboard'
  get 'recipe' => 'dashboard#recipe'
  get 'login' => 'dashboard#login'
  post  'list' => 'dashboard#list'
  post 'populate_cupboard' => 'dashboard#populate_cupboard'
  delete 'drop_from_cupboard/:id' => 'dashboard#drop_from_cupboard', as: 'drop_from_cupboard'

  match 'hostess' => redirect('http://fridge-hostess.herokuapp.com/auth/facebook'),via: [:post, :get]
  get 'auth/hostess/callback' => 'dashboard#show'

  root to: 'dashboard#show'

end
