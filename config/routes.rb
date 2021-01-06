Rails.application.routes.draw do

  constraints subdomain: 'app' do
    devise_for :user, :path => '', :path_names => { :sign_in => "login", :sign_out => "logout", :sign_up => "register" }
    resources :testimonials do
      get "new/:collect_code", on: :collection, to: "testimonials#collect_new", as: :collect_new
    end

    scope '/collect', as: "collect" do
      get "/", to: "dashboard#collect"
      get 'send_email', to: "collect#send_email"
      get 'shareable_link', to: "collect#shareable_link"
      get 'twitter_search', to: "collect#twitter_search"
      scope '/twitter_post', as: "twitter_post" do
        get 'new', to: "collect#twitter_post_new"
        post 'create', to: "collect#twitter_post_create"
      end
    end
    root to: 'dashboard#index', as: :app_root
  end

  root to: 'page#index'
end
