class DropServicesTable < ActiveRecord::Migration[6.0]
  def change
    drop_table :services
  end
end
