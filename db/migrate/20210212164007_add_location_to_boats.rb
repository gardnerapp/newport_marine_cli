class AddLocationToBoats < ActiveRecord::Migration[6.0]
  def change
    add_column :boats, :location, :string

  end
end
