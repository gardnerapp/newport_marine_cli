class CreateJoinTableAppointmentsServices < ActiveRecord::Migration[6.0]
  def change
    create_join_table :appointments, :services
  end
end
