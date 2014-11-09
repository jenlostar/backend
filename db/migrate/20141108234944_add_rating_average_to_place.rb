class AddRatingAverageToPlace < ActiveRecord::Migration
  def change
    add_column :places, :rating_average, :decimal
  end
end
