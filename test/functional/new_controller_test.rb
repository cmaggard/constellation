require File.dirname(__FILE__) + '/../test_helper'
require 'new_controller'

# Re-raise errors caught by the controller.
class NewController; def rescue_action(e) raise e end; end

class NewControllerTest < Test::Unit::TestCase
  fixtures :technicians, :customers, :units
  
  def setup
    @controller = NewController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
    @request.session[:technician] = technicians(:cody).id
  end

  # Replace this with your real tests.
  def test_index
    get :index
    
    assert_redirect :action => :find_customer
  end
  
  def test_find_customer_get_no_id
    get :find_customer
    
    assert_response :success
    assert_template 'find_customer'
  end
  
  def test_find_customer_get_with_id
    get :find_customer, :id => customers(:cody).id
    
    assert_equal session[:customer], customers(:cody).id
    assert_redirect :action => :find_unit
  end
  
  def test_find_customer_js_no_results
    xhr :post, :find_customer, { :customer => { :first_name => "", :last_name => "" } }
    assert_response :success
    assert_equal "Need a name", @response.body
    
    xhr :post, :find_customer, { :customer => { :first_name => "ZZZ", :last_name => "" } }
    assert_equal "No customer found", @response.body
  end
  
  def test_find_customer_js_results
    cody = customers(:cody)
    xhr :post, :find_customer, { :customer => { :first_name => cody.first_name, 
                                                :last_name => "" } }
    
    assert_response :success
    assert_match %r|<a href="/new/find_customer/#{cody.id}">Select</a>|, @response.body
  end
  
  def test_new_customer_no_session
    cust = Customer.new
    cust.first_name = "Jenn"
    cust.last_name = "Connor"
    cust.phone_number = "102-502-5912"
    
    post :edit_customer, { :customer => cust.attributes }
    assert_redirect :action => :find_unit
    jenn = Customer.find(:first, :conditions => ["phone_number = ?", "102-502-5912"])
    assert_equal session[:customer], jenn.id
  end
  
  def test_edit_customer_no_session
    cust = customers(:cody)
    cust.last_name = "Hawking"
    
    assert_equal cust.id, 1
    post :edit_customer, { :id => cust.id, :customer => cust.attributes }
    assert_redirect :action => :find_unit
    assert_equal session[:customer], cust.id
  end
  
  def test_new_customer_session
    cust = Customer.new
    cust.first_name = "Jenn"
    cust.last_name = "Connor"
    cust.phone_number = "102-502-5912"
    
    @request.session[:customer] = customers(:cody).id
    post :edit_customer, { :customer => cust.attributes }
    assert_redirect :action => :find_unit
    assert_equal session[:customer], customers(:cody).id
  end
  
  def test_find_unit_get_no_id
    
  end
end
