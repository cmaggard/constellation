class CreateCustomers < ActiveRecord::Migration
  def self.up
    create_table :customers do |t|
      t.column :first_name, :string
      t.column :last_name, :string
      t.column :phone_number, :string
      t.column :department, :string
    end
  end

  def self.down
    drop_table :customers
  end
end
