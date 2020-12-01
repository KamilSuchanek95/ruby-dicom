Rails.application.routes.draw do
  root 'examinations#index'

  resources :examinations
  #get 'examinations/:index' => 'examinations#index'
  get 'examinations/index', to: 'examinations#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html



end
