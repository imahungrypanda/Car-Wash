class RenameColumn < ActiveRecord::Migration[5.1]
  def change
    rename_column :vehicles, :type, :vehicle_type
  end
end
