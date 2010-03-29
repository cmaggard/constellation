class CreateUnits < ActiveRecord::Migration
  def self.up
    create_table :units do |t|
      t.column :serial_number, :string
      t.column :accessories, :string
      t.column :manufacturer_id, :integer
      t.column :type_id, :integer
      t.column :customer_id, :integer
    end
  end

  def self.down
    drop_table :units
  end
end
