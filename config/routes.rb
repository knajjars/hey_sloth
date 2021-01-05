Rails.application.routes.draw do
  constraints subdomain: 'app' do
    devise_for :users
    root to: 'dashboard#index', as: :app_root
  end

  root to: 'page#index'
end
