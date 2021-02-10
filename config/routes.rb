Rails.application.routes.draw do
  resources :game, only: %i[create show index] do
    post :play, on: :member
  end

  root to: 'games#index'
end
