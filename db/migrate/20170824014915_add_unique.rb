class AddUnique < ActiveRecord::Migration[5.1]
  def change
    remove_index :vehicles, :license_plate
    add_index    :vehicles, :license_plate, unique: true
  end
end
