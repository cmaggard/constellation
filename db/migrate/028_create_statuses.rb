class CreateStatuses < ActiveRecord::Migration
  def self.up
    create_table :statuses do |t|
      t.column :ticket_id, :integer
      t.column :key, :string
    end
  end

  def self.down
    drop_table :statuses
  end
end
