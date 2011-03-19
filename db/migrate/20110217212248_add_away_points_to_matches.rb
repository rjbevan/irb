class AddAwayPointsToMatches < ActiveRecord::Migration
  def self.up
    add_column :matches, :apts, :integer
  end

  def self.down
    remove_column :matches, :apts
  end
end
