class AdditionalTable < ApplicationRecord
    belongs_to :user
    validates :user_id, uniqueness: true
    has_one_attached :picture
    # Permite el acceso al atributo mismo
    attr_accessor :pic, :bio, :big_picture

  end