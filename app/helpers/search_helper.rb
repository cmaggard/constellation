module SearchHelper
  def status(ticket)
    return "Picked up" unless ticket.picked_up.nil?
    return "Closed" unless !ticket.closed?
    return "Claimed" unless ticket.claimed_by.nil?
    return "Awaiting Bench"
  end
end
