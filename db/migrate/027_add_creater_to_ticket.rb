class AddCreaterToTicket < ActiveRecord::Migration
  def self.up
    add_column :tickets, :created_by, :integer
    
    Ticket.reset_column_information
    
    Ticket.find(:all).each do |t|
      t.update_attribute(:created_by, t.notes.find(:first).technician)
    end
  end

  def self.down
    remove_column :tickets, :created_by
  end
end
