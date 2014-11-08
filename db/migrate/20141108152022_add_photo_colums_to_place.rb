class AddPhotoColumsToPlace < ActiveRecord::Migration
  def change
    add_column :places, :photo1, :oid
    add_column :places, :photo2, :oid
    add_column :places, :photo3, :oid
  end
end
