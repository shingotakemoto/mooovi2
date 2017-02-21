TechReviewSite::Application.routes.draw do
  devise_for :users
  root 'products#index'
  resources :users, only: [:show]
  resources :products, only: [:index, :show] do
    resources :reviews, only: [:new, :create]
    collection do
      get 'search'
    end
  end
end
