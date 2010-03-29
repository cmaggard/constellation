class AddDescriptionToUnit < ActiveRecord::Migration
  def self.up
    add_column :units, :description, :text
  end

  def self.down
    remove_column :units, :description
  end
end
