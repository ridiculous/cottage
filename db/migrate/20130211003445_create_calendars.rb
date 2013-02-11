class CreateCalendars < ActiveRecord::Migration
  def change
    create_table :calendars do |t|
      t.string :available_dates, limit: 5000
      t.datetime :refresh_date

      t.timestamps
    end
  end
end
