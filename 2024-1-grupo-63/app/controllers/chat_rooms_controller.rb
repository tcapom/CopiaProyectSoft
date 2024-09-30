class ChatRoomsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_chat_room, only: [:show]
  before_action :authorize_user!, only: [:show]

  # Muestra todos los chats a los cuales el usuario en sesión pertenezca
  def index
    @chat_rooms = current_user.chat_rooms
  end

  # Muestra un chat en función de su id
  # @param [int] id
  def show
    @chat_room = ChatRoom.find(params[:id])
    @message = Message.new
  end

  # Crea un chat
  def new
    @chat_room = ChatRoom.new
  end

  #Crea un chat en función de que sus parámetros estén correctos
  # @param [string] name
  # @param [list[int]] user_ids
  def create
    @chat_room = ChatRoom.new(chat_room_params)
    if @chat_room.save
      ChatRoomUser.create(chat_room: @chat_room, user: current_user)
      redirect_to @chat_room
    else
      render :new
    end
  end

  # Muestra los mensajes pertenecientes a un chat especificado
  # @param [int] id
  def messages
    @chat_room = ChatRoom.find(params[:id])
    render partial: 'messages', locals: { messages: @chat_room.messages }
  end

  # Busca un chat según su id
  # @param [int] id
  def set_chat_room
    @chat_room = ChatRoom.find(params[:id])
  end

  # Impide que un usuario pueda entrar a un chat si no pertenece a él
  def authorize_user!
    unless @chat_room.users.include?(current_user)
      redirect_to chat_rooms_path, alert: "No tienes permisos para entrar a este chat."
    end
  end

  private
  # Parámetros necesarios para crear el chat
  def chat_room_params
    params.require(:chat_room).permit(:name, user_ids: [])
  end
end