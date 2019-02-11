Rails.application.routes.draw do

  mount RailsAdmin::Engine => '/super_admin', as: 'rails_admin'

  devise_scope :user do
    root "devise/sessions#new"
    get '/logout' => 'devise/sessions#destroy'
  end

  get 'member', to: 'member#index'
  get 'admin', to: 'admin#index'
  get 'profile', to: 'users#show'

  devise_for :users, controllers: { invitations: 'users/invitations' }

  devise_scope :user do
    match "*path" => "devise/sessions#new", via: :all
    #match '*path' => redirect{ |p, req| req.flash[:notice] = "Error"; 'new_user_session_path' }, via: :get
  end

end