class CreateParts < ActiveRecord::Migration
  def self.up
    create_table :parts do |t|
      t.column :status, :string
      t.column :technician_id, :integer
      t.column :ticket_id, :integer
      t.column :part, :string
      
      t.column :requested_at, :timestamp
      t.column :ordered_at, :timestamp
      t.column :shipped_at, :timestamp
      t.column :received_at, :timestamp
      
      t.column :tracking_number, :string
    end
  end

  def self.down
    drop_table :parts
  end
end
