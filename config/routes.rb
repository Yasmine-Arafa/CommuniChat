Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check


  # to monitor the scheduled jobs using the Sidekiq Web UI
  # http://localhost:3000/sidekiq
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'


  # Defines the root path route ("/")
  # root "posts#index"

  resources :applications, param: :token, only: [] do    # use :token to identify applications

    post '/', on: :collection, to: 'applications#create' # create a new application
    get '/', on: :collection, to: 'applications#index' # read all applications
    get '/:token', on: :collection, to: 'applications#show' # read a specific application
    post '/:token', on: :collection, to: 'applications#update' # update a specific application (name)


    resources :chats, param: :number, only: [] do
      post '/', on: :collection, to: 'chats#create'   # create new chat   /applications/:application_token/chats
      get '/', on: :collection, to: 'chats#index'     # get all chats within app   /applications/:application_token/chats
      get '/:number', on: :collection, to: 'chats#show' # gat specific chat within app  /applications/:application_token/chats/:chat_number 

      resources :messages, only: [] do
        get '/search', on: :collection, to: 'messages#search' # GET /applications/:application_token/chats/:chat_number/messages/search?query=hello
        post '/', on: :collection, to: 'messages#create' # POST /applications/:application_token/chats/:chat_number/messages
        get '/', on: :collection, to: 'messages#index' # GET /applications/:application_token/chats/:chat_number/messages
        get '/:number', on: :collection, to: 'messages#show' # GET /applications/:application_token/chats/:chat_number/messages/:message_number
      end

    end
  
  end

  ## search  ###


end
