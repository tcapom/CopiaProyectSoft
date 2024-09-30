class CreateChatRoomActividads < ActiveRecord::Migration[7.1]
  def change
    create_table :chat_room_actividads do |t|
      t.string :name

      t.timestamps
    end
  end
end
