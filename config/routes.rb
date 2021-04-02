Rails.application.routes.draw do
  constraints subdomain: 'app' do
    devise_for :user, path: '',
                      path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register' }, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

    delete 'disconnect_authorization/:provider', to: 'users/authorization#disconnect', as: :disconnect_authorization

    resources :fire_link, except: :show, on: :member

    get 'hey-wall', to: 'hey_wall#show'

    resources :testimonials, only: %i[show destroy] do
      post 'toggle_showcase', to: 'testimonials#toggle_showcase', on: :member, as: 'toggle_showcase'
    end

    scope '/collect', as: 'collect' do
      get ':fire_link_id/send_email', to: 'collect#send_email_new', as: 'send_email_new'
      post ':fire_link_id/send_email', to: 'collect#send_email_create', as: 'send_email_create'

      get 'twitter_search', to: 'collect#twitter_search'
      delete 'tweet/:status_id', to: 'collect#delete_tweet', as: 'delete_tweet'
      scope '/twitter_post', as: 'twitter_post' do
        get 'new', to: 'collect#twitter_post_new'
        post 'create', to: 'collect#twitter_post_create'
      end
    end
    get '*path', to: redirect('/'), constraints: ->(req) { req.path.exclude? 'rails/active_storage' }
    root to: 'dashboard#index', as: :app_root
  end

  constraints subdomain: 'api' do
    get ':public_token/testimonials', to: 'api#list_testimonials', as: 'get_testimonials_json'
    get 'embed', to: 'embed#widget'
  end

  root to: 'page#index'

  get 'subscribe', to: 'subscription#index', as: 'subscribe'

  get ':fire_link_id', to: 'collect#from_fire_link_new', as: 'collect_from_fire_link_new'
  post ':fire_link_id', to: 'collect#from_fire_link_create', as: 'collect_from_fire_link_create'
end
