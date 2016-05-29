Rails.application.routes.draw do
  resource :map, only: :show
  resource :logplex, only: :create, controller: :logplex

  mount ActionCable.server => "/cable"
end
