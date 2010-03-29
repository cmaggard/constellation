class Technician < ActiveRecord::Base
  # ORM Mappings
  has_many :notes
  has_many :incoming_messages, :foreign_key => 'receiver_id', :class_name => "Message"
  has_many :outgoing_messages, :foreign_key => 'sender_id', :class_name => "Message"
  has_many :tickets, :foreign_key => 'claimed_by', :class_name => "Ticket"
  
  # Username is required to both exist and be unique
  validates_presence_of :username
  validates_uniqueness_of :username

  # Name is required to both exist and be unique
  validates_presence_of :name
  validates_uniqueness_of :name

  # Initials are required to both exist and be unique
  validates_presence_of :initials
  validates_uniqueness_of :initials
  
  def before_validation
    if self.username.nil? || self.username.empty?
      self.username = self.name.split[0].first + self.name.split[1] unless name.nil?
      self.username.downcase! unless username.nil?
    end
  end
end
