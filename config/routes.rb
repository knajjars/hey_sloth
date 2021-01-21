Rails.application.routes.draw do

  constraints subdomain: 'app' do
    devise_for :user, path: '',
               path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register' }, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

    delete 'disconnect_authorization/:provider', to: "users/authorization#disconnect", as: :disconnect_authorization

    resources :hey_boxes
    
    resources :testimonials do
      get 'video', to: 'testimonials#video_new', on: :new
      post 'video', to: 'testimonials#video_create', on: :collection
    end

    scope '/collect', as: 'collect' do
      get 'new/:tag', to: 'collect#new', as: "new"
      get '/', to: 'dashboard#collect'
      get 'send_email', to: 'collect#get_send_email'
      post 'send_email', to: 'collect#post_send_email'

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
end
