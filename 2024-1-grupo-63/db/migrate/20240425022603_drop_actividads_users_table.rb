class DropActividadsUsersTable < ActiveRecord::Migration[7.1]
  def change
    drop_table :actividads_users
  end
end
