class CreateTechnicians < ActiveRecord::Migration
  def self.up
    create_table :technicians do |t|
      t.column :initials, :string
      t.column :name, :string
    end
  end

  def self.down
    drop_table :technicians
  end
end
