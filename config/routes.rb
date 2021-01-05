Rails.application.routes.draw do

  constraints subdomain: 'app' do
    devise_for :user, :path => '', :path_names => { :sign_in => "login", :sign_out => "logout", :sign_up => "register" }
    resources :testimonials
    scope '/collect', as: "collect" do
      get "/", to: "dashboard#collect"
      get 'send_email', to: "collect#send_email"
      get 'shareable_link', to: "collect#shareable_link"
      get 'twitter_post', to: "collect#twitter_post"
      get 'twitter_search', to: "collect#twitter_search"
      get "/shared_url/:collect_code", to: "collect#shared_url", as: "shared_link"
    end
    root to: 'dashboard#index', as: :app_root
  end

  root to: 'page#index'
end
