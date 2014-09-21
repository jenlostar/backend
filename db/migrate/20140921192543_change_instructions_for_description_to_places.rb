class ChangeInstructionsForDescriptionToPlaces < ActiveRecord::Migration
  def change
    rename_column :places, :instructions, :description
  end
end
