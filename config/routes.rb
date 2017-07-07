Rails.application.routes.draw do
  resources :voters do
    get :search, on: :collection
    get :results, on: :collection
  end

  root to: "voters#search"
end
