class AddTipusToContribucions < ActiveRecord::Migration[6.0]
  def change
    add_column :contribucions, :tipus, :string
  end
end
