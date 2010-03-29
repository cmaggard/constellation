require File.dirname(__FILE__) + '/../test_helper'

class TicketTest < Test::Unit::TestCase
  fixtures :tickets, :technicians

  def setup
    
  end
  
  def test_open_priority_tickets
    @tickets = Ticket.open_priority_tickets
    assert_equal 1, @tickets.size
  end
  
  def test_open_regular_tickets
    @tickets = Ticket.open_regular_tickets
    assert_equal 1, @tickets.size
  end
  
  def test_pickup_tickets
    @tickets = Ticket.open_pickup_tickets
    assert_equal 1, @tickets.size
  end
  
  def test_my_open_priority_tickets
    @tickets = Ticket.my_priority_tickets(technicians(:cody).id)
    assert_equal 1, @tickets.size
  end
  
  def test_my_open_regular_tickets
    @tickets = Ticket.my_regular_tickets(technicians(:cody).id)
    assert_equal 1, @tickets.size
  end
  
  def test_nobodys_regular_tickets
    @tickets = Ticket.my_regular_tickets(1000)
    assert_equal 0, @tickets.size
    @tickets = Ticket.my_regular_tickets
    assert_equal 0, @tickets.size
  end
  
  def test_closed
    assert_equal false, tickets(:cdrom_problem).closed?
    assert_equal true, tickets(:dung_beetles).closed?
  end
end
