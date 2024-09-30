class CreateSolicituds < ActiveRecord::Migration[7.1]
  def change
    create_table :solicituds do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.belongs_to :actividad, index: true, foreign_key: true
      t.string :message
      t.string :status
      t.boolean :pending, default: true

      t.timestamps
    end
  end
end
