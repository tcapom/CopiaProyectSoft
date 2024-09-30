class Addglobaladmin < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :global_admin, :boolean, default: false
  end
end
