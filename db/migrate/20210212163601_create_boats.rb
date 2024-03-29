class CreateBoats < ActiveRecord::Migration[6.0]
  def change
    create_table :boats do |t|
      t.string :name
      t.integer :length
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
