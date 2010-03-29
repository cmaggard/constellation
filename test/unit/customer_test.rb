require File.dirname(__FILE__) + '/../test_helper'

class CustomerTest < Test::Unit::TestCase
  fixtures :customers

  def setup
    @cody = customers(:cody)
  end
  
  def test_first_last_name
    assert_equal "Cody Maggard", @cody.first_last_name
  end
  
  def test_last_first_name
    assert_equal "Maggard, Cody", @cody.last_first_name
  end
  
  def test_before_validation
    cust = Customer.new
    cust.first_name = "Don  "
    cust.last_name = "  Giovanni  "
    cust.phone_number = " 803-205-1025"
    assert cust.save
    assert_equal "Don", cust.first_name
    assert_equal "Giovanni", cust.last_name
    assert_equal "803-205-1025", cust.phone_number
  end
end
