class ChatRoomActividad < ApplicationRecord
  has_many :actividad_messages, dependent: :destroy
  belongs_to :actividad
end
