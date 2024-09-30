Rails.application.routes.draw do
  get 'messages/create'
  get 'chat_rooms/index'
  get 'chat_rooms/show'
  get 'chat_rooms/create'
  get 'home/index'
  devise_for :users
  root to: 'home#index' 

  devise_scope :user do
    get 'users/sign_out' => "devise/sessions#destroy"
  end
  get 'perfil', to: 'perfil#perfil_usuario'
  get 'perfil/modificar', to: 'perfil#modificar' 
  get '/search', to: 'additional_table#search', as: 'search'

  get 'followers_de_otro/:id', to: 'perfil#followers_de_otro', as: 'followers_de_otro'
  get 'followers', to: 'perfil#followers', as: 'followers'
  get 'followers/:id', to: 'perfil#followers_especifico', as: 'followers_especifico'
  get '/usuarios', to: 'home#index_users'

 
  get 'perfil/ver_perfil/:id', to: 'perfil#ver_perfil', as: 'ver_perfil'


  get 'agregar_info', to: 'additional_table#agregar_info'
  patch 'nueva_info', to: 'additional_table#modificar_info'

  get "crear_actividad", to: "actividad#crear_actividad"
  post "crear_actividad", to: "actividad#create"
  get "actividad/index", to: "actividad#index"
  
  resources :actividad, only: [:index, :show, :create]
  get "crear_actividad", to: "actividad#crear_actividad"
  post "crear_actividad", to: "actividad#create"
  get "ver_actividades_user", to: "actividad#ver_actividades_user"
  get "ver_solicitudes_user", to: "solicitud#ver_solicitudes_user"
  

  resources :actividad do
    resources :resenas, only: [:create, :destroy]
  end

 patch '/actividad/:id/update_photo', to: 'actividad#update_photo', as: 'update_photo_actividad'
  # config/routes.rb
  resources :users, only: [] do
    member do
      post 'request_follow', to: 'perfil#request_follow'
      post 'follow', to: 'perfil#follow'
      delete 'unfollow', to: 'perfil#unfollow'
      post 'accept_follow', to: 'perfil#accept_follow'
      post 'reject_follow', to: 'perfil#reject_follow'
    end
  end

  #Chats POR ALGUNA RAZON TIRA MAL
  resources :chat_rooms, only: [:index, :show, :new, :create] do
    member do
      get 'messages'
    end
    resources :messages, only: [:create]
  end
  
  scope "/actividad/:id" do
    #solicitudes
    get "ver_solicitudes_actividad", to: "solicitud#ver_solicitudes_actividad"
    delete "ver_solicitudes_actividad", to: "solicitud#manejar_solicitud"
    get "nueva_solicitud", to: "solicitud#nueva_solicitud"
    post "nueva_solicitud", to: "solicitud#crear_solicitud"
    # ver/quitar miembros
    get "ver_miembros", to: "actividad#ver_miembros"
    delete "ver_miembros", to: "actividad#sacar_miembro"

    # chat actividad
    resources :chat_room_actividad, only: [:index, :show]do
      get 'messages', to: 'chat_room_actividad#messages'
    end

    post 'chat_room_actividad/:id', to: 'actividad_message#create'
  end

  #Borrar usuarios
  delete 'user/:id', to: 'perfil#destroy', as: :destroy_user
  #Borrar actividades
  delete 'actividads/:id', to: 'actividad#destroy'
  #Actividades archivadas
  get 'archived_activities', to: 'actividad#archived_index', as: 'archived_activities'
  patch 'actividad/:id/archive', to: 'actividad#archive', as: 'archive_actividad'

  
    # GET	      /photos	          photos#index	display a list of all photos
    # GET	      /photos/new	      photos#new	return an HTML form for creating a new photo
    # POST	    /photos	          photos#create	create a new photo
    # GET	      /photos/:id	      photos#show	display a specific photo
    # GET	      /photos/:id/edit	photos#edit	return an HTML form for editing a photo
    # PATCH/PUT	/photos/:id	      photos#update	update a specific photo
    # DELETE	  /photos/:id	      photos#destroy	delete a specific photo
  #get 'render/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  #root "render#index"
end
