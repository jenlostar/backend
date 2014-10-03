class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.integer :user_id
      t.integer :place_id
      t.datetime :date

      t.timestamps
    end
  end
end
