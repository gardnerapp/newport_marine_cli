class DropAppointmentServices < ActiveRecord::Migration[6.0]
  def change
    drop_table :appointments_services
    remove_column :appointments, :string

  end
end
