class CreateAdditionalTable < ActiveRecord::Migration[7.1]
  def change
    create_table :additional_tables do |t|
      t.references :user, null: false, foreign_key: true
      t.string :pronouns
      t.string :username
      t.string :phone

      t.timestamps
    end
  end
end
