require File.dirname(__FILE__) + '/../test_helper'
require 'search_controller'

# Re-raise errors caught by the controller.
class SearchController; def rescue_action(e) raise e end; end

class SearchControllerTest < Test::Unit::TestCase
  fixtures :technicians
  
  def setup
    @controller = SearchController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
    @request.session[:technician] = technicians(:cody).id
  end

  # Replace this with your real tests.
  def test_index
    get :index
    
    assert_response :success
    assert_template 'index'
  end
  
  def test_search
    post :search, :search => 'term'
    
    assert_response :success
    assert_template 'search'
  end
end
