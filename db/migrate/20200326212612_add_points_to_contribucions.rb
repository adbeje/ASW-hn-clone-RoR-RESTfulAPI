class AddPointsToContribucions < ActiveRecord::Migration[6.0]
  def change
     add_column :contribucions, :points, :integer, default:0
     
  end
end
