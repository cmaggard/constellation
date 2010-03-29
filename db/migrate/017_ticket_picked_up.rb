class TicketPickedUp < ActiveRecord::Migration
  def self.up
    add_column :tickets, :picked_up, :datetime
  end

  def self.down
    remove_column :tickets, :picked_up
  end
end
