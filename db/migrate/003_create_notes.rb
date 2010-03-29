class CreateNotes < ActiveRecord::Migration
  def self.up
    create_table :notes do |t|
      t.column :technician_id, :integer
      t.column :note, :text
      t.column :ticket_id, :integer
      t.column :created_at, :timestamp
    end
  end

  def self.down
    drop_table :notes
  end
end
