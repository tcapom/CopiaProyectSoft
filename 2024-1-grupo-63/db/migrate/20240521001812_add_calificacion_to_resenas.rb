class AddCalificacionToResenas < ActiveRecord::Migration[7.1]
  def change
    add_column :resenas, :calificacion, :integer
  end
end
