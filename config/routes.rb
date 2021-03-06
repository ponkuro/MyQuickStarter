Rails.application.routes.draw do
  devise_for :users, path_names: { sign_in: "login", sign_out: "logout" },
    controllers: {
      registrations: "users/registrations",
      omniauth_callbacks: "users/omniauth_callbacks"
    }
  root 'top#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
