class AddCommentToReply < ActiveRecord::Migration[6.0]
  def change
      add_column :replies, :comment_id, :integer
      add_index  :replies, :comment_id
  end
end
