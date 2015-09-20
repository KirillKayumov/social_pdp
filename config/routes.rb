Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: "registrations",
    sessions: "sessions",
    omniauth_callbacks: "omniauth_callbacks"
  }

  root to: "pages#home"

  resources :accounts, only: :destroy
end
