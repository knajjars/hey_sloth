Rails.application.routes.draw do
  constraints subdomain: 'app' do
    devise_for :user, :path => '', :path_names => { :sign_in => "login", :sign_out => "logout", :sign_up => "register" }
    resources :testimonials
    root to: 'dashboard#index', as: :app_root
  end

  root to: 'page#index'
end
