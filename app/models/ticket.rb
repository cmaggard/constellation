require_dependency "search"

class Ticket < ActiveRecord::Base
  searches_on :all
  
  # ORM
  has_many :notes
  belongs_to :unit
  belongs_to :customer
  belongs_to :claimed_by, :foreign_key => "claimed_by", :class_name => "Technician"
  belongs_to :created_by, :foreign_key => "created_by", :class_name => "Technician"
  has_one :status
  
  # Validations
  validates_presence_of :problem
  validates_presence_of :parts, :on => :update, :message => "is required."
  validates_presence_of :labor, :on => :update, :message => "is required."
  validates_presence_of :services_performed, :on => :update, :message => "is required."
  validates_presence_of :quote_number, :on => :update, :message => "is required."
  validates_numericality_of :parts, :on => :update, :message => "must be a number."
  validates_numericality_of :labor, :on => :update, :message => "must be a number."
  validates_numericality_of :quote_number, :on => :update, :message => "must be a number."
  
  def self.open_priority_tickets
    find_all_by_priority_and_completed_at(true,nil)
  end
  
  def self.open_regular_tickets
    find_all_by_priority_and_completed_at(false,nil)
  end
  
  def self.open_pickup_tickets
    find(:all, :include => [:customer, {:unit => :type}, {:unit => :manufacturer}], 
               :conditions => ["completed_at IS NOT NULL AND picked_up IS NULL"])
  end
  
  def self.my_priority_tickets(user=nil)
    return [] if user.nil?
    Ticket.find(:all, :conditions => [ "claimed_by = ? AND completed_at IS NULL AND priority = ?", 
                                       user, true])
  end
  
  def self.my_regular_tickets(user=nil)
    return [] if user.nil?
    Ticket.find(:all, :conditions => [ "claimed_by = ? AND completed_at IS NULL AND priority = ?", 
                                       user, false])
  end
    
  def self.apple_tickets(priority=false)
    find(:all, :include => [:customer, {:unit => :type}, {:unit => :manufacturer}], 
               :conditions => ["manufacturers.name = 'Apple' AND completed_at IS NULL AND priority = ?", 
                                priority])
  end
    
  def self.pc_tickets(priority=false)
    find(:all, :include => [:customer, {:unit => :type}, {:unit => :manufacturer}], 
               :conditions => ["manufacturers.name != 'Apple' AND completed_at IS NULL AND priority = ?", 
                                priority])
  end  
    
  def closed?
    !completed_at.nil?
  end
  
  def claimed?
    !claimed_by.nil?
  end
  
  def picked_up?
    !picked_up.nil?
  end
  
  def reopen!
    [:taxable, :completed_at, :quote_number, :services_performed, :parts, :labor].each do |a|
      update_attribute(a, nil)
    end
  end
  
  def add_note(tech, message)
    n = Note.new( {:note => message, :technician => Technician.find(tech)} )
    notes << n
  end
end