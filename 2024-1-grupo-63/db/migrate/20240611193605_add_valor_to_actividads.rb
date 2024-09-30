class AddValorToActividads < ActiveRecord::Migration[7.1]
  def change
    add_column :actividads, :valor, :integer, default: 0, null: false
  end
end