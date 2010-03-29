class CounterController < ApplicationController
  def index
    if request.get?
      @counterwork = Counterwork.new
    elsif request.post?
      @counterwork = Counterwork.new(params[:counterwork])
      
      flash[:notice] = "Your donation is truly appreciated." if @counterwork.save
    end
  end
end