class ModifyCustomer < ActiveRecord::Migration
  def self.up
    add_column :customers, :alt_phone_number, :string
    add_column :customers, :email_address, :string
  end

  def self.down
    remove_column :customers, :alt_phone_number
    remove_column :customers, :email_address
  end
end
