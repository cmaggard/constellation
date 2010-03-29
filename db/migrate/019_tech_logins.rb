class TechLogins < ActiveRecord::Migration
  def self.up
    add_column :technicians, :username, :string
    add_column :technicians, :hashed_password, :string
    add_column :technicians, :password_hash, :string
    add_column :technicians, :admin, :boolean
  end

  def self.down
    remove_column :technicians, :username
    remove_column :technicians, :hashed_password
    remove_column :technicians, :password_hash
    remove_column :technicians, :admin
  end
end
