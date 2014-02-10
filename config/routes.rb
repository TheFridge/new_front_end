FrontEnd::Application.routes.draw do

  get 'dashboard' => 'dashboard#show'
  get 'cupboard' => 'dashboard#cupboard'
  get 'recipe' => 'dashboard#recipe'
  get 'login' => 'dashboard#login'
  get 'logout' => 'dashboard#logout'
  post  'list' => 'dashboard#list'
  post 'populate_cupboard' => 'dashboard#populate_cupboard'

  match 'hostess' => redirect('http://fridge-hostess.herokuapp.com/auth/facebook'),via: [:post, :get]
  get 'auth/hostess/callback' => 'dashboard#show'

  root to: 'dashboard#show'

end
