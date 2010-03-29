require File.dirname(__FILE__) + '/../test_helper'
require 'queue_controller'

# Re-raise errors caught by the controller.
class QueueController; def rescue_action(e) raise e end; end

class QueueControllerTest < Test::Unit::TestCase
  fixtures :technicians
  
  def setup
    @controller = QueueController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
    @request.session[:technician] = technicians(:cody).id
  end

  # Replace this with your real tests.
  def test_regular_queue
    get :index
    
    assert_response :success
    assert_template 'index'
  end
  
  def test_personal_queue
    get :personal
    
    assert_response :success
    assert_template 'index'
  end
  
  def test_pickup_queue
    get :pickup
    
    assert_response :success
    assert_template 'pickup'
  end
end
