class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.string :name, limit: 50
      t.integer :minimum_amount
      t.integer :maximum_amount
      t.integer :estimated_duration
      t.integer :place_id

      t.timestamps
    end
  end
end
