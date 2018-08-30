Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'teams#index'

  get 'nation_teams', to: 'teams#show'
end
