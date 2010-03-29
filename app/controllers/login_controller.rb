require 'digest/sha2'

class LoginController < ApplicationController
  skip_before_filter :require_login

  def index
    redirect_to :controller => :queue and return if logged_in?
  end

  def login
    @username = params[:username]
    password = params[:password]
    
    # Go ahead and grab the only tech with that username.
    # Will return nil if none found
    tech = Technician.find(:first, :conditions => ["username = ?", @username])
    
    if tech.nil?
      flash[:notice] = $MESSAGES['invalid_login']
      redirect_to :action => :index and return
    end
    
    unless tech.enabled
      flash[:notice] = $MESSAGES['acct_disabled'] 
      redirect_to :action => :index and return
    end

    if ( tech.hashed_password.nil? || tech.hashed_password.empty? )
      session[:technician] = tech.id
      redirect_to :action => :set_pass and return
    end
  
    process_login(tech, password)
    if session[:technician]
      redirect_to :controller => "/" and return
    else
      redirect_to :action => :index and return
    end
  end
  
  def logout
    session[:technician] = nil
    session[:admin] = nil
    redirect_to :action => "index"
  end
  
  def set_pass
    @tech = Technician.find(session[:technician])
    if request.post?
      if params[:password] != params[:password_confirm]
        error_and_render "Passwords do not match", :set_pass
      elsif params[:password] == ""
        error_and_render "Password should not be blank", :set_pass
      else
        @tech = Technician.find(session[:technician])
        @tech.password_hash = generate_hash
        @tech.hashed_password = hash(params[:password],@tech.password_hash)
        @tech.save
        flash[:notice] = "Password saved"
        redirect_to "/" and return
      end
    end
  end
  
  private
  def error_and_render(notice = "Invalid username or password.", action = :index)
    flash[:notice] = notice
    render :action => action and return
  end
  
  def generate_hash
    [Array.new(6){rand(256).chr}.join].pack("m").chomp
  end
  
  def hash(password, salt)
    Digest::SHA256.hexdigest(password + salt)
  end
  
  def process_login(tech,password)
    if tech.hashed_password == hash(password,tech.password_hash)
      session[:technician] = tech.id
      session[:admin] = true if tech.admin?
    end
  end
end