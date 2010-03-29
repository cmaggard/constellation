require 'digest/sha2'

class StatusController < ApplicationController
  skip_before_filter :require_login

  def index
  end

  def lookup
    if request.get?
      render :action => :index and return if params[:key].nil?
      sta = Status.find_by_key(params[:key])
      if sta.nil?
        flash[:error] = "Invalid key specified."
        render :action => :index
      end
      @ticket = sta.ticket
    else  # request.post? (ASSUMPTION)
      info = params[:info]
      @ticket = Ticket.find(
                :first, :include => [:customer],
                :conditions => 
                      ["tickets.id = ? AND customers.first_name LIKE ? AND customers.last_name LIKE ?",
                        info[:ticket], info[:first_name], info[:last_name] 
                      ] 
               )
      if @ticket.nil?
        flash[:error] = "That ticket/name combination is invalid."
        render :action => :index and return
      end

      if @ticket.status.nil?
        salt = [Array.new(6){rand(256).chr}.join].pack("m").chomp
      
        key = Digest::SHA256.hexdigest( @ticket.customer.first_name + 
                                         @ticket.customer.last_name + 
                                         @ticket.id.to_s + salt )

        @ticket.create_status( :key => key )
      end
      
    end

    if @ticket.picked_up?
      @status = "picked_up"
    elsif @ticket.closed?
      @status = "closed"
    elsif @ticket.claimed?
      @status = "claimed"
    else
      @status = "awaiting_bench"
    end
  end
end
