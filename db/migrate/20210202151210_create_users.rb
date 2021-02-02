class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.string :password_digest
      # TODO index, updated @, created @ etc and index for boat
      t.timestamps
    end
  end
end
