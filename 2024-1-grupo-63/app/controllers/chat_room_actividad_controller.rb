class ChatRoomActividadController < ApplicationController
  before_action :set_actividad, only: [:show]
  before_action :authorize_user!, only: [:show]

  # Muestra todos los chats a los cuales el usuario en sesión pertenezca
  def index
    redirect_to home_index_path
  end

  # Muestra un chat en función de su id
  # @param [int] id
  def show
    @actividad = Actividad.find_by(id: params[:id]) 
      @chat_room_actividad = ChatRoomActividad.find_by(id: params[:id])
      @actividad_messages = ActividadMessage.where(chat_room_actividad_id: @chat_room_actividad.id)
  end

  # Muestra los mensajes pertenecientes a un chat especificado
  # @param [int] id
  def messages
    @chat_room_actividad = ChatRoomActividad.find(params[:id])
      @actividad_messages = ActividadMessage.where(chat_room_actividad_id: @chat_room_actividad.id)
      render partial: 'messages', locals: { messages: @actividad_messages }
  end 

  # Busca un chat según su id
  # @param [int] id
  def set_actividad
    @actividad = Actividad.find_by(id: params[:id]) 
  end

  # Impide que un usuario pueda entrar a un chat si no pertenece a él
  def authorize_user!
    unless @actividad.users.include?(current_user)
      redirect_to actividad_index_path, alert: "No tienes permisos para entrar a este chat."
    end
  end
end
