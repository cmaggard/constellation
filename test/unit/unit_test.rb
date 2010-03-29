require File.dirname(__FILE__) + '/../test_helper'

class UnitTest < Test::Unit::TestCase
  fixtures :units, :manufacturers, :types
  
  def setup
    @dell_desktop = units(:dell_desktop)
  end
  
  def test_manufacturer_type
    assert_equal "Dell Desktop", @dell_desktop.manufacturer_type
  end
  
  def test_before_validation
    u = Unit.new
    u.manufacturer = manufacturers(:dell)
    u.type = types(:desktop)
    u.serial_number = "abc123"
    u.save
    assert_equal "ABC123", u.serial_number
  end
end
