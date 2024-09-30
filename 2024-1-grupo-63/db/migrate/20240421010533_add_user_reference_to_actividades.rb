class AddUserReferenceToActividades < ActiveRecord::Migration[6.0]
  def change
    add_reference :actividads, :user, foreign_key: true
  end
end