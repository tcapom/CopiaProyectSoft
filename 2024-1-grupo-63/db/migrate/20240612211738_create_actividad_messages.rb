class CreateActividadMessages < ActiveRecord::Migration[7.1]
  def change
    create_table :actividad_messages do |t|
      t.text :content

      t.timestamps
    end
  end
end
