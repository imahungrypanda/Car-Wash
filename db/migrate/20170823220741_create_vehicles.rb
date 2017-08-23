class CreateVehicles < ActiveRecord::Migration[5.1]
  def change
    create_table :vehicles do |t|
      t.string :type, null: false
      t.string :license_plate, null: false
      t.index  :license_plate

      t.timestamps
    end
  end
end
