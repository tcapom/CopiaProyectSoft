class Solicitud < ApplicationRecord
  validates :user, :actividad, presence:true
  validates :status, inclusion: { in: ["", "sent", "rejected", "accepted"] }
  validates_length_of :message, :maximum => 100
  belongs_to :user
  belongs_to :actividad
end
