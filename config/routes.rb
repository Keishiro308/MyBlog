Rails.application.routes.draw do
  get 'posts/tagged/:tag' => 'posts#tag'
  get 'posts/pick_up' => 'posts#pick_up'
  post  'posts/pick_up_update' => 'posts#pick_up_update'
  resources :posts
  get '/' => 'posts#index'
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
