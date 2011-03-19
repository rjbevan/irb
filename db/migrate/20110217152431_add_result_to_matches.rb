class AddResultToMatches < ActiveRecord::Migration
  def self.up
    add_column :matches, :result, :string
  end

  def self.down
    remove_column :matches, :result
  end
end
