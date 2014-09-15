class CreatePlaces < ActiveRecord::Migration
  def change
    create_table :places do |t|
      t.string :name, limit: 255
      t.string :address, limit: 255
      t.string :instructions, limit: 255
      t.string :mobile_phone, limit: 10
      t.string :land_line, limit: 10

      t.timestamps
    end
  end
end
