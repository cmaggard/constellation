class TicketClaim < ActiveRecord::Migration
  def self.up
    add_column :tickets, :claimed_by, :integer
  end

  def self.down
    remove_column :tickets, :claimed_by
  end
end
