Rails.application.routes.draw do
  resources :orders
  namespace :aa do
    resources :bbs
  end
end
