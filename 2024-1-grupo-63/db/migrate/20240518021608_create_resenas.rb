class CreateResenas < ActiveRecord::Migration[7.1]
  def change
    create_table :resenas do |t|
      t.references :user, null: false, foreign_key: true
      t.references :actividad, null: false, foreign_key: true
      t.string :contenido

      t.timestamps
    end
  end
end
