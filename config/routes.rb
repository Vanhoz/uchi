Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'repositories#new'

  resources :repositories, only: %i[new create show]
end
