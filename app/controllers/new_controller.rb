class NewController < ApplicationController
  def index
    redirect_to :action => :find_customer
  end
  
  def find_customer
    clear_new_ticket_session!
    unless params[:id].nil?
      session[:customer] = params[:id].to_i
      params[:id] = nil
      redirect_to :action => :find_unit and return
    else
      respond_to do |request|
        request.html { @customer = Customer.new }
        request.js do
          @first_name = params[:customer][:first_name].strip + "%"
          @last_name = params[:customer][:last_name].strip + "%"
          if @first_name.length == 1 and @last_name.length == 1
            render_text "Need a name"
            return
          end # first name and last name blank?
          @customers = Customer.find(:all, :conditions => 
                                           [ "first_name LIKE ? AND last_name LIKE ?", 
                                             @first_name, @last_name], :limit => 10)
          if @customers.empty?
            render_text "No customer found"
            return
          end # customers.empty?
          render :partial => "customer", :collection => @customers and return
        end # request.js
      end # respond_to
    end # if params[:id]
  end
  
  def edit_customer
    redirect_to :action => :find_unit and return if session[:customer]
    @customer = params[:id] ? Customer.find(params[:id]) : Customer.new
    if request.post?
      @customer.update_attributes(params[:customer])
      if @customer.save
        session[:customer] = @customer.id
        redirect_to :action => :find_unit and return
      end # @customer.save
      render :action => 'find_customer' and return
    end # request.post?
  end
  
  def find_unit
    if params[:id]
      session[:unit] = params[:id].to_i
      redirect_to :action => :new_ticket and return
    else
      session[:unit] = nil
      respond_to do |wants|
        wants.html do
          @custunits = Customer.find(session[:customer]).units
          @unit = Unit.new
        end # wants.html
        wants.js do
          @serial = (request.raw_post || request.query_string).strip.upcase
          if @serial.empty? 
            render_text ""
            return
          end # @serial.empty?
          @serial += "%"
          @units = Unit.find(:all, :conditions => [ "serial_number LIKE ?", @serial], :limit => 10)
          if @units.nil? 
            render_text "No units found."
          else
            render :partial => "unit", :collection => @units
          end # units.nil?
        end # wants.js
      end # respond_to
    end # if params[:id]
  end
  
  def edit_unit
    redirect_to :action => :new_ticket, :id => @unit.id and return if session[:unit]
    @unit = params[:id] ? Unit.find(params[:id]) : Unit.new
    if request.post?
      @unit.update_attributes(params[:unit])
      if @unit.save
        @customer = Customer.find(session[:customer])
        @customer.units << @unit
        session[:unit] = @unit.id
        redirect_to :action => :new_ticket and return
      end
    end # request.post?    
  end
  
  def new_ticket
    if request.get?
      @ticket = Ticket.new
      @note = Note.new
    elsif request.post?
      # Required models
      @ticket = Ticket.new(params[:ticket])
      @note = Note.new(params[:note])
      @customer = Customer.find(session[:customer])
      @unit = Unit.find(session[:unit])
      
      # Assignments
      @note.note = "Service ticket created"
      @note.save
      @ticket.notes << @note
      @ticket.customer = @customer
      @ticket.unit = @unit
      @ticket.created_by = Technician.find(params[:note][:technician_id])

      if @ticket.save
        flash[:notice] = "Ticket created successfully, service ID is ##{@ticket.id}."
        redirect_to :controller => 'view', :id => @ticket.id and return
      end # if @ticket.save
    end # request.post?
  end
end
