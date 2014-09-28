class AddKindToService < ActiveRecord::Migration
  def change
    add_column :services, :kind, :integer, default: 0
  end
end
