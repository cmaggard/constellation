require File.dirname(__FILE__) + '/../test_helper'

class TechnicianTest < Test::Unit::TestCase
  fixtures :technicians

  # Replace this with your real tests.
  def test_provided_username
    tek = Technician.new
    tek.name = "Alan Albrecht"
    tek.initials = "AA"
    tek.username = "blargh"
    tek.save
    assert_equal "blargh", tek.username
  end
  
  def test_nonprovided_username
    tek = Technician.new
    tek.name = "Jerry Hames"
    tek.initials = "JH"
    tek.save
    assert_equal "jhames", tek.username
  end
end
