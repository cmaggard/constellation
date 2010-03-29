require File.dirname(__FILE__) + '/../test_helper'

class MessageTest < Test::Unit::TestCase
  fixtures :messages, :technicians

  def test_send_message
    cody, charles = technicians(:cody), technicians(:charles)
    
    Message.send_new(cody.id, charles.id, "Hello")
    
    msg = Message.find(:first, :conditions => ["message = ?", "Hello"])
    assert_equal msg.sender, cody
    assert_equal msg.receiver, charles
  end
end
