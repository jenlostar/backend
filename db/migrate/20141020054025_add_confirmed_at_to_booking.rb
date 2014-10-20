class AddConfirmedAtToBooking < ActiveRecord::Migration
  def change
    add_column :bookings, :confirmed_at, :datetime, default: nil
  end
end
