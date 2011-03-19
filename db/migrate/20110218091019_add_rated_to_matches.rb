class AddRatedToMatches < ActiveRecord::Migration
  def self.up
    add_column :matches, :rated, :boolean
  end

  def self.down
    remove_column :matches, :rated
  end
end
