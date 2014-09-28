class RemoveEstimatedDurationFromService < ActiveRecord::Migration
  def change
    remove_column :services, :estimated_duration, :integer
  end
end
