class PopulateUnitInformation < ActiveRecord::Migration
  def self.up
    Manufacturer.create :name => "Dell"
    Manufacturer.create :name => "Apple"
    Manufacturer.create :name => "Compaq"
    Manufacturer.create :name => "HP"
    Manufacturer.create :name => "Gateway"
    Manufacturer.create :name => "Emachines"
    Manufacturer.create :name => "Sony"
    Manufacturer.create :name => "Toshiba"
    Manufacturer.create :name => "Micron"
    Manufacturer.create :name => "Acer"
    Manufacturer.create :name => "Clone"
    Manufacturer.create :name => "Other"
    
    Type.create :name => "Desktop"
    Type.create :name => "Laptop"
    Type.create :name => "Server"
    Type.create :name => "Imac"
  end

  def self.down
    execute "TRUNCATE manufacturers"
    execute "TRUNCATE types"
  end
end
