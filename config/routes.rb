Rails.application.routes.draw do
  get 'notifications/link_through'

  get 'profiles/show'

  devise_for :users, controllers: { registrations: 'registrations' }

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'posts#index'
  
  get 'notifications', to: 'notifications#index'

  get ':user_name', to: 'profiles#show', as: :profile
  get ':user_name/edit', to: 'profiles#edit', as: :edit_profile
  patch ':user_name/edit', to: 'profiles#update', as: :update_profile

  get 'notifications/:id/link_through', to: 'notifications#link_through', as: :link_through

  resources :posts do
    resources :comments
    member do
      get 'like'
      get 'unlike'
    end
  end

end
