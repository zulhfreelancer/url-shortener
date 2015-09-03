Rails.application.routes.draw do
  
  root "links#index"
  resources :links
  get ':slug' => 'links#show'

end
