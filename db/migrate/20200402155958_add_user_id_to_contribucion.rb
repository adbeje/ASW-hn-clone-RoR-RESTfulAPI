class AddUserIdToContribucion < ActiveRecord::Migration[6.0]
  def change
    add_column :contribucions, :user_id, :integer
    add_index  :contribucions, :user_id
  end
end
