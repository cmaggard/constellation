class QueueController < ApplicationController
  def index
    @priqueue = Ticket.open_priority_tickets
    @regqueue = Ticket.open_regular_tickets
  end
  
  def personal
    user = session[:technician]
    @priqueue = Ticket.my_priority_tickets(user)
    @regqueue = Ticket.my_regular_tickets(user)
    render :action => :index
  end
  
  def apple
    @priqueue = Ticket.apple_tickets(true)
    @regqueue = Ticket.apple_tickets(false)
    render :action => :index
  end
  
  def pc
    @priqueue = Ticket.pc_tickets(true)
    @regqueue = Ticket.pc_tickets(false)
    render :action => :index
  end
  
  def pickup
    @tickets = Ticket.open_pickup_tickets
  end
end
