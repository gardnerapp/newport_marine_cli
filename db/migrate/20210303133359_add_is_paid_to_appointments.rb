class AddIsPaidToAppointments < ActiveRecord::Migration[6.0]
  def change
    add_column :appointments, :is_paid, :boolean, default: false

  end
end
