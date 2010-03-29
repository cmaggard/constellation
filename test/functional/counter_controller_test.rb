require File.dirname(__FILE__) + '/../test_helper'
require 'counter_controller'

# Re-raise errors caught by the controller.
class CounterController; def rescue_action(e) raise e end; end

class CounterControllerTest < Test::Unit::TestCase
  def setup
    @controller = CounterController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_get_index
    get :index
    assert :success
  end
end
