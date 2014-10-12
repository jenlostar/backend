class RemovePolymorphicAssociationFromSchedule < ActiveRecord::Migration
  def self.up
    rename_column :schedules, :schedulable_id, :place_id
    remove_column :schedules, :schedulable_type
  end

  def self.down
  end
end
