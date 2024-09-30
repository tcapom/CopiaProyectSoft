class AddPicAndBioToAdditionalTables < ActiveRecord::Migration[7.1]
  def change
    add_column :additional_tables, :picture, :string, default: "/assets/images/predeterminada.jpg"
    add_column :additional_tables, :big_picture, :string, default: "/assets/images/predeterminada.jpg"
    add_column :additional_tables, :biografia, :string, default: "Cuentanos sobre ti"
  end
end
