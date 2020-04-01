class AddContribucionIdToComment < ActiveRecord::Migration[6.0]
  def change
    add_column :comments, :contribucion_id, :integer
    add_index  :comments, :contribucion_id
  end
end
