Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :users, only: [:create, :new, :show] do
    resources :counters, only: :update
  end

  resources :sessions, only: [:create, :new, :destroy]

  root to: redirect("/sessions/new")

end