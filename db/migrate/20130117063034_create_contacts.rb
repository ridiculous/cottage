class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :name
      t.string :number_of_people
      t.string :email
      t.string :address
      t.string :phone
      t.date :arrival_date
      t.date :departure_date
      t.string :message
      t.timestamps
    end
  end
end
