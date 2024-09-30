class AddAdminToActividadUser < ActiveRecord::Migration[7.1]
  def change
    #add_column :actividads_users, :admin, :boolean, default: false
    add_column :actividads_users, :admin, :boolean, default: false
  end
end
