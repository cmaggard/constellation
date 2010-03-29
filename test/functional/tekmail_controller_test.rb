require File.dirname(__FILE__) + '/../test_helper'
require 'tekmail_controller'

# Re-raise errors caught by the controller.
class TekmailController; def rescue_action(e) raise e end; end

class TekmailControllerTest < Test::Unit::TestCase
  fixtures :technicians, :messages
  
  def setup
    @controller = TekmailController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
    @request.session[:technician] = technicians(:cody).id
  end

  # Replace this with your real tests.
  def test_index
    get :index
    
    assert_redirected_to :action => :unread
  end
  
  def test_list_unread_messages
    get :unread
    
    assert_response :success
    assert_template 'index'
  end
  
  def test_list_read_messages
    get :read
    
    assert_response :success
    assert_template 'index'
  end
  
  def test_list_all_messages
    get :all
    
    assert_response :success
    assert_template 'index'
  end
  
  def test_view_my_message
    get :view, :id => messages(:from_charles_to_cody).id
    
    assert_response :success
    assert_template 'view'
  end
  
  def test_view_others_message
    get :view, :id => messages(:from_cody_to_charles).id
    
    assert_redirected_to :action => :unread
    assert_equal flash[:notice], "That message does not belong to you."
  end
end
