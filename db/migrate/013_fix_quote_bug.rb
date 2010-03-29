class FixQuoteBug < ActiveRecord::Migration
  def self.up
    remove_column :tickets, :quote
    add_column :tickets, :quote_number, :string
  end

  def self.down
    remove_column :tickets, :quote_number
    add_column :tickets, :quote, :integer
  end
end
