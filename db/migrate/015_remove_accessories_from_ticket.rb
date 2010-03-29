class RemoveAccessoriesFromTicket < ActiveRecord::Migration
  def self.up
    remove_column :tickets, :accessories
  end

  def self.down
    add_column :tickets, :accessories, :string
  end
end
