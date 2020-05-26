require 'sidekiq/web'

Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }
#  mount Sidekiq::Web => '/sidekiq'

  root to: 'pages#home'
  resources :campaigns, except: [:new] do
    post 'raffle', on: :member
  end

  resources :members, only: [:create, :destroy, :update]
  get 'members/:token/opened', to: 'members#opened'

  require 'sidekiq/web'
  Sidekiq::Web.use Rack::Auth::Basic do |username, password|
    username == 'mm' && password == 'mendes'
  end
  mount Sidekiq::Web => '/sidekiq'
end