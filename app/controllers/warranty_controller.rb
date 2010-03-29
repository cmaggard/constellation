class WarrantyController < ApplicationController
  def index
    #outstanding_orders
  end
  
  def outstanding_orders
    pagination(["received_at IS NULL"])
  end
  
  def previous_orders
    pagination(["received_at IS NOT NULL"])
  end
  
  def all_orders
    pagination(nil)
  end
  
  def request_part
    if request.get?
      @part = Part.new
      @part.ticket_id = params[:id]
    elsif request.post?
      ticket = Ticket.find(params[:id])
      technician = Technician.find(params[:part][:technician_id])
      @part = Part.new(params[:part])
      @part.technician = technician
      @part.ticket = ticket
      if @part.save
        flash[:notice] = "Part requested."
        redirect_to :controller => '/view', :action => :index, :id => ticket_id and return
      else
        flash[:notice] = "Error in saving part request.  Grovel before Cody and beg his forgiveness."
      end
    end
  end
  
  private
  def pagination(conditions)
    @part_pages, 
    @parts = paginate( :parts, 
                          :conditions => conditions,
                          :order => 'created_at DESC',
                          :per_page => 20)
    render :action => "index"
  end
end
