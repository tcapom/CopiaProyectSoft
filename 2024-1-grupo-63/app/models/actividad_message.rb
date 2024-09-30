class ActividadMessage < ApplicationRecord
  belongs_to :user
  belongs_to :chat_room_actividad
end
