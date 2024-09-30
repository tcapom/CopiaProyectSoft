class Actividad < ApplicationRecord
    validates :titulo, presence: true
    validates :valor, presence: true
    validates_length_of :titulo, :maximum => 50
    validates_length_of :descripcion, :maximum => 100
    
    has_many :memberships, dependent: :destroy
    has_many :users, through: :memberships
    has_many :solicituds, dependent: :destroy
    has_many :resenas, dependent: :destroy 
    has_one_attached :url_imagen 
    has_one :chat_room_actividad, dependent: :destroy
end
