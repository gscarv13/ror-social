Rails.application.routes.draw do

  root 'posts#index'

  devise_for :users

  resources :users, only: [:index, :show]
  resources :posts, only: [:index, :create] do
    resources :comments, only: [:create]
    resources :likes, only: [:create, :destroy]
  end

  get 'friendship/:id', to: 'friendships#add_friend', as: 'add_friend'
  get 'friendship_add/:id', to: 'friendships#confirm', as: 'confirm_friendship'
  delete 'friendship/:id', to: 'friendships#refuse', as: 'refuse_friendship'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
