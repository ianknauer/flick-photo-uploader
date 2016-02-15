Rails.application.routes.draw do

  get "/albums/:id/upload", to: "albums#edit"

  resources :albums, except: [:new, :create] do
    resources :photos
  end
  resources :customers do
    resources :albums, only: [:new, :create]
    collection do
      post :search, to: "customers#search"
    end
  end
end
