class CreateContribucions < ActiveRecord::Migration[6.0]
  def change
    create_table :contribucions do |t|
      t.text :title
      t.text :url
      t.text :text

      t.timestamps
    end
    add_index :contribucions, :url, unique: true
  end
end
