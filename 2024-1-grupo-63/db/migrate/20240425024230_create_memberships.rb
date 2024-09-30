class CreateMemberships < ActiveRecord::Migration[7.1]
  def change
    create_table :memberships do |t|
      t.belongs_to :actividad, null: false, foreign_key: true
      t.belongs_to :user, null: false, foreign_key: true
      t.boolean :admin, default: false
      t.timestamps
    end
  end
end
