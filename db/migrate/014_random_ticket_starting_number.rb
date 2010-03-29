class RandomTicketStartingNumber < ActiveRecord::Migration
  def self.up
    execute "ALTER TABLE tickets AUTO_INCREMENT = 1507"
  end

  def self.down
  end
end
