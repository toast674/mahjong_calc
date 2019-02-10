Rails.application.routes.draw do
  # get 'top_pages/home'
  root to: 'top_pages#home'
  post 'result', to:'results#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
