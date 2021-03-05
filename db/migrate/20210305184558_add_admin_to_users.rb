class AddAdminToUsers < ActiveRecord::Migration[6.0]
  def change
    # TODO Use seed data to create default administrators
    add_column :users, :admin, :boolean, default: false
  end
end
