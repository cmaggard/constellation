class CreateCounterworks < ActiveRecord::Migration
  def self.up
    create_table :counterworks do |t|
      t.column :technician_id, :integer
      t.column :description, :text
      t.column :created_at, :datetime
    end
  end

  def self.down
    drop_table :counterworks
  end
end
