Rails.application.routes.draw do
  constraints subdomain: 'app' do
    devise_for :user, path: '',
               path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register' }, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

    delete 'disconnect_authorization/:provider', to: 'users/authorization#disconnect', as: :disconnect_authorization

    resources :shareable_links, except: :show

    resources :testimonials, only: %i[index show destroy] do
      post 'toggle_showcase', to: 'testimonials#toggle_showcase', on: :member, as: 'toggle_showcase'
    end

    scope '/collect', as: 'collect' do
      get ':shareable_link_id/send_email', to: 'collect#send_email_new', as: 'send_email_new'
      post ':shareable_link_id/send_email', to: 'collect#send_email_create', as: 'send_email_create'

      get 'twitter_search', to: 'collect#twitter_search'
      delete 'tweet/:status_id', to: 'collect#delete_tweet', as: 'delete_tweet'
      scope '/twitter_post', as: 'twitter_post' do
        get 'new', to: 'collect#twitter_post_new'
        post 'create', to: 'collect#twitter_post_create'
      end
    end
    get '*path' => redirect('/')
    root to: 'dashboard#index', as: :app_root
  end

  constraints subdomain: 'external' do
    get ':public_token/testimonials', to: 'external#list_testimonials', as: 'get_testimonials_json'
  end

  root to: 'page#index'

  get ':shareable_link_id', to: 'collect#from_shareable_link_new', as: 'collect_from_shareable_link_new'
  post ':shareable_link_id', to: 'collect#from_shareable_link_create', as: 'collect_from_shareable_link_create'
end
