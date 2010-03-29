class MessageRead < ActiveRecord::Migration
  def self.up
    add_column :messages, :opened, :boolean
  end

  def self.down
    remove_column :messages, :opened
  end
end
