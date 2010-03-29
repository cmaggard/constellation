class AddIndices < ActiveRecord::Migration
  def self.up
    num = 5000
    say_with_time "#{num} Finds of Serial Number pre-index" do
      num.times do
        Unit.find(:all, :conditions => ["serial_number = ?", "9z3zt21"])
      end
    end
    
    add_index :units, :serial_number, :type => "unique", :index_name => "idx_serial"
    
    say_with_time "#{num} Finds of Serial Number post-index" do
      num.times do
        Unit.find(:all, :conditions => ["serial_number = ?", "9z3zt21"])
      end
    end 
    
  end

  def self.down
    remove_index :units, "idx_serial"
  end
end
