class CreateRatings < ActiveRecord::Migration
  def self.up
    create_table :ratings do |t|
      t.decimal :rate
      t.date :date
      t.references :country

      t.timestamps
    end
  end

  def self.down
    drop_table :ratings
  end
end
