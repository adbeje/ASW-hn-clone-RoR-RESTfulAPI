class AddCacheVotesToContribucions < ActiveRecord::Migration[6.0]
  def self.up
    add_column :contribucions, :cached_votes_total, :integer, :default => 0
    add_column :contribucions, :cached_votes_up, :integer, :default => 0
    add_column :contribucions, :cached_votes_down, :integer, :default => 0
    add_index  :contribucions, :cached_votes_total
    add_index  :contribucions, :cached_votes_up
    add_index  :contribucions, :cached_votes_down
  end

  def self.down
    remove_column :contribucions, :cached_votes_total
    remove_column :contribucions, :cached_votes_up
    remove_column :contribucions, :cached_votes_down
  end
end
