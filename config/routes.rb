Rails.application.routes.draw do
  resources :earthquakes, only: [:index, :show, :create, :destroy] do
    resources :comments, only: [:create], shallow: true
  end
end