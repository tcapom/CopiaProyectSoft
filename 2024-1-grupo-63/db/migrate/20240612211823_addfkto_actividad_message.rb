class AddfktoActividadMessage < ActiveRecord::Migration[7.1]
  def change
    add_reference :actividad_messages, :user
    add_reference :actividad_messages, :chat_room_actividad
  end
end
