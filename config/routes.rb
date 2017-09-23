Rails.application.routes.draw do
  get 'notifications', to: 'notifications#index'
  get 'notifications/:id/link_through', 
      to: 'notifications#link_through', 
      as: :link_through

  get 'profiles/show'

  devise_for :users, :controllers => { registrations: 'registrations' }
  resources :posts do
    resources :comments
    member do
      get 'like'
      get 'unlike'
    end
  end
  root 'posts#index'
  # Users web paths
  get ':user_name', to: 'profiles#show', as: :profile
  get ':user_name/edit', to: 'profiles#edit', as: :edit_profile
  patch ':user_name', to: 'profiles#update', as: :update_profile
end
