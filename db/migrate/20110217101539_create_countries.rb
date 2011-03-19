class CreateCountries < ActiveRecord::Migration
  def self.up
    create_table :countries do |t|
      t.string :name
      t.decimal :rating_current
      t.date :date_current

      t.timestamps
    end
  end

  def self.down
    drop_table :countries
  end
end
