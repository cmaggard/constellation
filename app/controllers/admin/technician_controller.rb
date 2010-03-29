class Admin::TechnicianController < ApplicationController
  skip_before_filter :require_login
  before_filter :admin?
  
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @technician_pages, @technicians = paginate :technicians, :per_page => 10
  end

  def show
    @technician = Technician.find(params[:id])
  end

  def new
    @technician = Technician.new
  end

  def create
    @technician = Technician.new(params[:technician])
    @technician.enabled = true
    if @technician.save
      flash[:notice] = 'Technician was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @technician = Technician.find(params[:id])
  end

  def update
    @technician = Technician.find(params[:id])
    if @technician.update_attributes(params[:technician])
      flash[:notice] = 'Technician was successfully updated.'
      redirect_to :action => 'show', :id => @technician
    else
      render :action => 'edit'
    end
  end
  
  def toggle
    tech = Technician.find(params[:id])
    tech.toggle! :enabled
    flash[:notice] = "Technician 'enabled' status toggled.  Long live the Emperor."
    redirect_to :action => :index
  end
  
  def reset
    @tech = Technician.find(params[:id])
    @tech.password_hash = nil
    @tech.hashed_password = nil
    @tech.save
    flash[:notice] = "Password reset for #{@tech.name}"
    redirect_to :action => :index
  end
end
