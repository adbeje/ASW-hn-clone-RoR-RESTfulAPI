class AddTitleToComments < ActiveRecord::Migration[6.0]
  def change
    add_column :comments, :title, :text
    add_index  :comments, :title
  end
end
