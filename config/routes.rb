Feedlists::Application.routes.draw do
  resources :users
  root :to => 'welcome#home'

end
