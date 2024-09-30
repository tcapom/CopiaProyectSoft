class Membership < ApplicationRecord
  belongs_to :actividad
  belongs_to :user
  
end
