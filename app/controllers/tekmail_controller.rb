class TekmailController < ApplicationController
  def index
    redirect_to :action => :unread
  end
  
  def unread
    pagination( ["receiver_id = ? AND opened = ?", 
                 session[:technician], false] )
  end
  
  def read
    pagination( ["receiver_id = ? AND opened = ?", 
                 session[:technician], true ] )
  end
  
  def all
    pagination( ["receiver_id = ?", 
                session[:technician] ] )
  end
  
  def view
    @message = Message.find(params[:id])
    if (@message.receiver != Technician.find(session[:technician]))
      flash[:notice] = "That message does not belong to you."
      redirect_to :action => :unread and return
    end
    @message.toggle(:opened) unless @message.opened?
    @message.save
  end
  
  def send_message
    if request.get?
      @sender = Technician.find(session[:technician])
      @receiver = params[:receiver]
      @message = Message.new
    else
      @sender = session[:technician]
      @receiver = params[:message][:receiver]
      @message = params[:message][:message]
      if Message.send_new(@sender, @receiver, @message)
        num = rand(20)
        flash[:notice] = "Message sent!  YOU WIN!  Dispensing #{num} tickets!<br />
                          Make sure to stop by the ticket booth to redeem them!"
        redirect_to :action => :unread and return
      end
    end
  end
  
  private
  def pagination(conditions)
    @message_pages, 
    @messages = paginate( :messages, 
                          :conditions => conditions,
                          :order => 'created_at DESC',
                          :per_page => 20)
    render :action => "index"
  end
end
