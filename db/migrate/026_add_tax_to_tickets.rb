class AddTaxToTickets < ActiveRecord::Migration
  def self.up
    add_column :tickets, :taxable, :boolean, :default => true
    
    Ticket.reset_column_information
    
    Ticket.find(:all).each do |t|
      t.update_attribute(:taxable, true)
    end
  end

  def self.down
    remove_column :tickets, :taxable
  end
end
