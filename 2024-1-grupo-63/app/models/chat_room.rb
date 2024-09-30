class ChatRoom < ApplicationRecord
  has_many :chat_room_users, dependent: :destroy
  has_many :users, through: :chat_room_users
  has_many :messages
  validates :name, presence: true
  validate :users_presence

  # Para la creación de un chat, verifica de que el usuario haya marcado al menos otro usuario para crearse
  def users_presence
    errors.add(:base, "Debe seleccionar al menos un usuario") if users.blank?
  end
end
