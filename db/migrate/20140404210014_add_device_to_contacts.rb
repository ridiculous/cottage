class AddDeviceToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :device, :string
  end
end
