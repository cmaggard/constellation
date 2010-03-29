class ReportController < ApplicationController
  skip_before_filter :require_login
  before_filter :admin?
  
  def index
    
  end
end
