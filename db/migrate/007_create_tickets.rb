class CreateTickets < ActiveRecord::Migration
  def self.up
    create_table :tickets do |t|
      t.column :problem, :text
      t.column :accessories, :string
      t.column :quote, :integer
      t.column :created_at, :timestamp
      t.column :completed_at, :timestamp
      t.column :customer_id, :integer
      t.column :unit_id, :integer
    end
  end

  def self.down
    drop_table :tickets
  end
end
