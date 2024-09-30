class ActividadMessageController < ApplicationController
  # Crea un mensaje para añadirlo a un chat de actividad
  # @param [int] id
  def create
    @chat_room_actividad = ChatRoomActividad.find(params[:id])
      @message = ActividadMessage.new(content: params[:message])
      @message.user_id = current_user.id
      @message.chat_room_actividad_id = @chat_room_actividad.id
      
      if @message.content != ""
        if @message.save
          respond_to do |format|
            format.html { redirect_to @chat_room_actividad }
          format.js
          end
        end
      end
  end
end
