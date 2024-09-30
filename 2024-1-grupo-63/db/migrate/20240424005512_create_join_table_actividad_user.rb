class CreateJoinTableActividadUser < ActiveRecord::Migration[7.1]
  def change
    create_join_table :actividads, :users do |t|
      t.index [:actividad_id, :user_id]
      t.index [:user_id, :actividad_id]
    end
  end
end
