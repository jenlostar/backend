class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.integer  :day_of_week
      t.time     :start_time
      t.time     :end_time
      t.integer  :schedulable_id
      t.string   :schedulable_type, limit: 50
      t.timestamps
    end
  end
end
