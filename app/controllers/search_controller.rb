class SearchController < ApplicationController
  def index
    
  end
  
  def search
    @tickets = Ticket.search params[:search], :include => [:customer, :unit], :order => "tickets.created_at DESC"
  end
end
