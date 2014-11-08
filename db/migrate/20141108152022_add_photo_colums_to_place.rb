class AddPhotoColumsToPlace < ActiveRecord::Migration
  def change
    add_column :places, :photo1, :oid, null: false
    add_column :places, :photo2, :oid, null: false
    add_column :places, :photo3, :oid, null: false
  end
end
