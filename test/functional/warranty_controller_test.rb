require File.dirname(__FILE__) + '/../test_helper'
require 'warranty_controller'

# Re-raise errors caught by the controller.
class WarrantyController; def rescue_action(e) raise e end; end

class WarrantyControllerTest < Test::Unit::TestCase
  def setup
    @controller = WarrantyController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
