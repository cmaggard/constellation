class ViewController < ApplicationController
  def index
    redirect_to :controller => :queue unless params[:id]
    @ticket = Ticket.find(params[:id])
    @notes = @ticket.notes
    @admin = session[:admin]
  end
end
