class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :memberships, dependent: :destroy
  has_many :actividads, through: :memberships
  has_many :actividads, dependent: :destroy
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :solicituds, dependent: :destroy
  has_one :additional_table, dependent: :destroy
  has_many :resenas, dependent: :destroy
  #Info de chats
  has_many :chat_room_users, dependent: :destroy
  has_many :chat_rooms, through: :chat_room_users

  has_many :messages, dependent: :destroy
  has_many :actividad_messages, dependent: :destroy

  after_create :create_additional_table


  has_many :followers, class_name: "Follower", foreign_key: "followed_id"
  has_many :followed_users, through: :followers, source: :follower



  has_many :follow_requests, foreign_key: :followed_id, dependent: :destroy
  has_many :followers, through: :follow_requests, source: :follower

  has_many :followings, class_name: "Follower", foreign_key: "follower_id"
  has_many :following_users, through: :followings, source: :followed
  



  # Crea una extensión de User que le permite guardar más atributos que los que permite devise por defecto
  def create_additional_table
    AdditionalTable.create(user: self)
    additional_table.phone = "Agrega un número de téfono"
    additional_table.username = "Crea un nombre"
    additional_table.pronouns = "Agrega pronombres"
    additional_table.pic = "https://i.pinimg.com/564x/ee/b1/91/eeb191da96860e0046f1e4782766a499.jpg"
    additional_table.save 
  end
end
