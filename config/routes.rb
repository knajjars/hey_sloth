Rails.application.routes.draw do
  get 'collect/send_email'
  get 'collect/shareable_link'
  get 'collect/twitter_post'
  get 'collect/twitter_search'
  constraints subdomain: 'app' do
    devise_for :user, :path => '', :path_names => { :sign_in => "login", :sign_out => "logout", :sign_up => "register" }
    resources :testimonials
    get "/collect", to: "dashboard#collect"

    root to: 'dashboard#index', as: :app_root
  end

  root to: 'page#index'
end
