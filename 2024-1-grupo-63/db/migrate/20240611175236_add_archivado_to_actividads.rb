class AddArchivadoToActividads < ActiveRecord::Migration[7.1]
  def change
    add_column :actividads, :archivado, :boolean, default: false
  end
end
