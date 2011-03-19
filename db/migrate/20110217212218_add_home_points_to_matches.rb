class AddHomePointsToMatches < ActiveRecord::Migration
  def self.up
    add_column :matches, :hpts, :integer
  end

  def self.down
    remove_column :matches, :hpts
  end
end
