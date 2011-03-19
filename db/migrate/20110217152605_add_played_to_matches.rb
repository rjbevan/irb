class AddPlayedToMatches < ActiveRecord::Migration
  def self.up
    add_column :matches, :played, :boolean
  end

  def self.down
    remove_column :matches, :played
  end
end
