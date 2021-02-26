class AddTotalToAppointment < ActiveRecord::Migration[6.0]
  def change
    add_column :appointments, :total, :float
  end
end
