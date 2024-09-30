class Resena < ApplicationRecord
  belongs_to :user
  belongs_to :actividad
  validates :calificacion, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }
  validates :user, presence: true
  validates :actividad, presence: true
end
