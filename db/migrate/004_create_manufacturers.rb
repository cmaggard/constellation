class CreateManufacturers < ActiveRecord::Migration
  def self.up
    create_table :manufacturers do |t|
      t.column :name, :string
    end
  end

  def self.down
    drop_table :manufacturers
  end
end
