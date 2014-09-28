class AddDurationToService < ActiveRecord::Migration
  def change
    add_column :services, :duration, :time
  end
end
