class MessagesController < ApplicationController
  before_action :authenticate_user!
  # Crea un mensaje para poder añadirlo a un chat
  # @param [int] chat_room_id
  def create
    @chat_room = ChatRoom.find(params[:chat_room_id])
    @message = @chat_room.messages.build(message_params)
    @message.user = current_user
    if @message.content == ""
      render 'chat_rooms/show', notice: "El mensaje debe tener contenido"
    elsif @message.save
      respond_to do |format|
        format.html { redirect_to @chat_room }
        format.js
      end
    else
      render 'chat_rooms/show'
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end