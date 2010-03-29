module ViewHelper
  def serial_link(ticket)
    serial = ticket.unit.serial_number
    if ticket.unit.manufacturer.name == "Dell"
      return link_to(serial, "http://support.dell.com/support/topics/global.aspx/support/my_systems_info/en/details?c=us&amp;cs=19&amp;l=en&amp;s=dhs&amp;ServiceTag=" + serial)
    elsif ticket.unit.manufacturer.name == "Apple"
      # maybe do something with apple here later, but as of right now, it's impossible
      return serial
    else
      return serial
    end
  end
  
  def checked_by_when(ticket)
    "#{ticket.created_by.initials} on #{time_formatter(ticket.created_at)}"
  end
  
  def claimer(ticket)
    ticket.claimed_by.nil? ? "Unclaimed" : ticket.claimed_by.initials
  end
  
  def total(ticket)
    total = ticket.parts + ticket.labor
    total *= 1.0825 if ticket.taxable?
    
    # Hack to round up to nearest cent. number_to_currency always does floor()
    total = (total * 100).round / 100.0     if ticket.taxable?
                                       
    str = number_to_currency total
    str = str + " (with tax)" if ticket.taxable?
    str
  end
end
