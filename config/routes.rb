Rails.application.routes.draw do
  devise_for :users

  root to: 'visitors#home'

  resource :dashboard

  resources :emails, only: [:show, :new, :create] do
    collection do
      get :inbox
      get :sent
    end
  end

  scope '/admin' do
    resources :users
  end
end
