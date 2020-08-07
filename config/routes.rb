Rails.application.routes.draw do
  resources :produtos
  resources :clientes
  root to: "clientes#index"
end
