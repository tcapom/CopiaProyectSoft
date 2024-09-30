class AddFKtoActividadforChat < ActiveRecord::Migration[7.1]
  def change
    add_reference :chat_room_actividads, :actividad
    add_reference :chat_room_actividads, :user
  end
end
