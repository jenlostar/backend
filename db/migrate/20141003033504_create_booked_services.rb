class CreateBookedServices < ActiveRecord::Migration
  def change
    create_table :booked_services do |t|
      t.integer :booking_id
      t.string :service_name, limit: 50
      t.time :service_duration

      t.timestamps
    end
  end
end
