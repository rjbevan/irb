class AddTournamentIdToMatches < ActiveRecord::Migration
  def self.up
    add_column :matches, :tournament_id, :integer
  end

  def self.down
    remove_column :matches, :tournament_id
  end
end
