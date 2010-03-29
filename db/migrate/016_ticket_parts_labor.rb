class TicketPartsLabor < ActiveRecord::Migration
  def self.up
    add_column :tickets, :services_performed, :text
    add_column :tickets, :parts, :float
    add_column :tickets, :labor, :float
  end

  def self.down
    remove_column :tickets, :services_performed
    remove_column :tickets, :parts
    remove_column :tickets, :labor
  end
end
