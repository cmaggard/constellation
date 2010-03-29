require_dependency "search"

class Note < ActiveRecord::Base
  belongs_to :technician
  belongs_to :ticket
  
  def self.add(id, message, tech = session[:technician])
    n = Note.new
    n.ticket_id = id
    n.note = message
    n.technician_id = tech
    n.save
  end
end
