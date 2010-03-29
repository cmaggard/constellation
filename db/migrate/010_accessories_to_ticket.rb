class AccessoriesToTicket < ActiveRecord::Migration
  def self.up
    remove_column :units, :accessories
    add_column :tickets, :power_cord, :boolean
    add_column :tickets, :bag, :boolean
    add_column :tickets, :discs, :boolean
    add_column :tickets, :misc_accessories, :string
  end

  def self.down
    add_column :units, :accessories, :string
    remove_column :tickets, :power_cord
    remove_column :tickets, :bag
    remove_column :tickets, :discs
    remove_column :tickets, :misc_accessories
  end
end
