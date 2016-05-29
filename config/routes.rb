Rails.application.routes.draw do
  root "maps#show"

  resource :map, only: :show
  resource :logplex, only: :create, controller: :logplex

  mount ActionCable.server => "/cable"
end
