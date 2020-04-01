class RemoveSubmissionIdFromComments < ActiveRecord::Migration[6.0]
  def change

    remove_column :comments, :submission_id, :integer
  end
end
