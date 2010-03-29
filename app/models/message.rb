class Message < ActiveRecord::Base
  belongs_to :sender, :foreign_key => 'sender_id', :class_name => "Technician"
  belongs_to :receiver, :foreign_key => 'receiver_id', :class_name => "Technician"
  
  validates_presence_of :message
  
  def self.send_new(from_tech,to_tech,message)
    msg = Message.new
    msg.sender = Technician.find(from_tech)
    msg.receiver = Technician.find(to_tech)
    msg.message = message
    msg.opened = false
    msg.save
  end
end
