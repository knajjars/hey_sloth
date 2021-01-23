Rails.application.routes.draw do
  constraints subdomain: 'app' do
    devise_for :user, path: '',
               path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register' }, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

    delete 'disconnect_authorization/:provider', to: "users/authorization#disconnect", as: :disconnect_authorization

    resources :shareable_links

    resources :testimonials, only: [:index, :show, :destroy] do
      post 'toggle_showcase', to: "testimonials#toggle_showcase", on: :member, as: "toggle_showcase"
    end

    scope '/collect', as: 'collect' do
      get '/', to: 'dashboard#collect'
      get '/send_email/:tag', to: 'collect#send_email_new', as: "send_email_new"
      post '/send_email/:tag', to: 'collect#send_email_create', as: "send_email_create"

      get 'twitter_search', to: 'collect#twitter_search'
      delete 'tweet/:status_id', to: 'collect#delete_tweet', as: 'delete_tweet'
      scope '/twitter_post', as: 'twitter_post' do
        get 'new', to: 'collect#twitter_post_new'
        post 'create', to: 'collect#twitter_post_create'
      end
    end
    root to: 'dashboard#index', as: :app_root
  end

  root to: 'page#index'

  get '/:tag', to: 'collect#from_shareable_link_new', as: "collect_from_shareable_link_new"
  post '/:tag', to: 'collect#from_shareable_link_create', as: "collect_from_shareable_link_create"
end
