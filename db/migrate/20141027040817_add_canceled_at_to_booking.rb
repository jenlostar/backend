class AddCanceledAtToBooking < ActiveRecord::Migration
  def change
    add_column :bookings, :canceled_at, :datetime
  end
end
