class Part < ActiveRecord::Base
  belongs_to :ticket
  belongs_to :technician
  
  acts_as_state_machine :initial => :requested, :column => 'status'
  
  state :requested
  state :ordered, 
        :enter => Proc.new { |p| p.ordered_at = Time.now }
  state :shipped,
        :enter => Proc.new { |p| p.shipped_at = Time.now }
  state :received,
        :enter => Proc.new { |p| p.received_at = Time.now }
  
  event(:order) { transitions :from => :requested, :to => :ordered }
  
  def before_save
    self.requested_at = Time.now if self.new_record?
  end
  
  def human_status
    status.to_s.sub('_',' ').capitalize
  end
end
