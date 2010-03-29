def report(date = 1.week.ago, charges = false)
  raise ArgumentError unless date.class == "Time"
  h = Hash.new
  conditions = [ "created_at >= ? " +
                 "AND completed_at IS NOT NULL" +
                 " AND claimed_by IS NOT NULL",
                 date.to_s(:db) ]
          
  if charges
    conditions[0] += " AND (parts > 0 OR labor > 0)"
  end
  
  closed_tickets = Ticket.find( :all, :conditions => conditions, 
                                :include => :claimed_by
                              )
                              
  techs = Technician.find(:all, :conditions => ["enabled = ?", true])
  h = techs.inject({}) do |hash, t|
    hash.merge( { t.name => 0 } )
  end
  
  closed_tickets.each do |t|
    h[t.claimed_by.name] += 1 if h.has_key?(t.claimed_by.name) 
  end
  
  h = h.select { |k,v| v > 0 }
  
  h.sort.each do |elem|
    puts "#{elem[0]}: #{elem[1]}"
  end
  
  return h
end
