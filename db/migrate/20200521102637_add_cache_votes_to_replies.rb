class AddCacheVotesToReplies < ActiveRecord::Migration[6.0]
  def self.up
    add_column :replies, :cached_votes_total, :integer, :default => 0
    add_column :replies, :cached_votes_up, :integer, :default => 0
    add_column :replies, :cached_votes_down, :integer, :default => 0
    add_index  :replies, :cached_votes_total
    add_index  :replies, :cached_votes_up
    add_index  :replies, :cached_votes_down
  end

  def self.down
    remove_column :replies, :cached_votes_total
    remove_column :replies, :cached_votes_up
    remove_column :replies, :cached_votes_down
  end
end