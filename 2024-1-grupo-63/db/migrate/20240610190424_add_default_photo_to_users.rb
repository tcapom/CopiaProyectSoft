class AddDefaultPhotoToUsers < ActiveRecord::Migration[7.1]
  def change
    change_column :additional_tables, :picture, :string
  end
end
