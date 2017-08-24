class AddColumns < ActiveRecord::Migration[5.1]
  def change
    add_column :vehicles, :visit_count, :integer, default: 0
    add_column :vehicles, :tailgate_down, :boolean, default: false
    add_column :vehicles, :muddy_bed, :boolean, default: false
  end
end
