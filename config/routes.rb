Rails.application.routes.draw do
  resource :logplex, only: :create, controller: :logplex
end
