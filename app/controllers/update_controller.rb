class UpdateController < ApplicationController
  def index
    render_text "Update what?"
  end
  
  def claim
    redirect_to :controller => 'queue' unless params[:id]
    claiming_tech = Technician.find(session[:technician])
    tic = Ticket.find(params[:id])
    if tic.claimed_by.nil?
      flash[:notice] = "Ticket claimed by Arch-Technician #{claiming_tech.name}!"
      note = "Unit claimed by #{claiming_tech.name}"
    else
      prev_tech = tic.claimed_by
      if claiming_tech == prev_tech
        flash[:notice] = "You can't claim your own unit, much like you cannot 
                          triple stamp a double stamp."
      else
        flash[:notice] = "Ticket stolen away by Master Technician 
                          #{claiming_tech.name} from the slightly 
                          less-Master Technician #{prev_tech.name}!"
        note = "Unit claimed by #{claiming_tech.name} from #{prev_tech.name}"
      end # techs the same?
    end #ticket claimed?
    tic.update_attribute(:claimed_by, claiming_tech)
    unless note.nil?
      @note = Note.new
      @note.technician = claiming_tech
      @note.note = note
      tic.notes << @note
    end
    redirect_to :controller => 'view', :id => params[:id]
  end
  
  def close
    @ticket = Ticket.find(params[:id])
    if @ticket.claimed_by.nil?
      flash[:notice] = "Can't close an unclaimed ticket.  YOU LOSE."
      redirect_to :controller => '/view', :id => @ticket.id
    end
    if request.get?
      @ticket.parts = 0
      @ticket.labor = 0
    elsif request.post?
      @note = Note.new(params[:note])
      @note.note = "Service ticket closed"
      @ticket.update_attributes(params[:ticket])
      @ticket.completed_at = Time.now
      @ticket.notes << @note
      render :action => 'close' and return unless @ticket.save
      flash[:notice] = "Ticket closed!"
      redirect_to :controller => 'view', :id => @ticket.id
    end # request.post?
  end
  
  def pickup
    @ticket = Ticket.find(params[:id])
    if @ticket.completed_at.nil?
      flash[:notice] = "Trying to pick up something that hasn't been closed." \
                       "  You're a horrible tech."
      redirect_to :controller => 'view', :id => @ticket.id and return
    end
    if request.post?
      @ticket.update_attribute(:picked_up, Time.now)
      flash[:notice] = "Ticket picked up.  HOORAY FOR ZOIDBERG."
      redirect_to :controller => 'queue' and return
    end
    redirect_to :controller => 'view', :id => @ticket.id
  end
  
  def note
    if request.get?
      @notes = Ticket.find(params[:id]).notes
    elsif request.post?
      if params[:note]
        @note = Note.new(params[:note])
        @ticket = Ticket.find(params[:id])
        @note.save
        @ticket.notes << @note
        if (!@ticket.claimed_by.nil? && @note.technician != @ticket.claimed_by)
          Message.send_new(@note.technician.id, @ticket.claimed_by.id, 
                           "Ticket ##{@ticket.id}: #{@note.note}")
        end
        render :action => "new_note.rjs", :local => { :note => @note }
      else
        @notes = Ticket.find(params[:id]).notes
        render :partial => 'notes'
      end # params[:note]
    end # request
  end # note
  
  def reopen
    if session[:admin]
      ticket = Ticket.find(params[:id])
      ticket.reopen!
      ticket.add_note(session[:technician], "Administrative Action: Ticket reopened.")
      flash[:notice] = "Ticket reopened.  I'd put something clever here but it isn't nice to make fun of retarded people."
      redirect_to :controller => 'view', :id => params[:id]
    end
  end
end
