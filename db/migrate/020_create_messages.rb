class CreateMessages < ActiveRecord::Migration
  def self.up
    create_table :messages do |t|
      t.column :message, :text
      t.column :created_at, :timestamp
      t.column :sender_id, :integer
      t.column :receiver_id, :integer
    end
  end

  def self.down
    drop_table :messages
  end
end
