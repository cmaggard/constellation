class AdminDisable < ActiveRecord::Migration
  def self.up
    add_column :technicians, :enabled, :boolean
    for tech in Technician.find(:all)
      tech.update_attribute(:enabled, true)
    end
  end

  def self.down
    remove_column :technicians, :enabled
  end
end
