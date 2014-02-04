FrontEnd::Application.routes.draw do

  get 'dashboard' => 'dashboard#show'
  get 'cupboard' => 'dashboard#cupboard'
  get 'recipe' => 'dashboard#recipe'

  root to: 'dashboard#show'

end
