class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.date :booking_date
      t.time :start_time
      t.time :end_time
      t.string :roomnum
      t.string :name

      t.timestamps null: false
    end
  end
end
  