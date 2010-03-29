require File.dirname(__FILE__) + '/../spec_helper'

describe "A customer's initial state" do
  before(:each) do
    @first_name = "productivus"
    @last_name = "tritium"
    @phone_number = "806-294-1025"
    @customer = Customer.new( :first_name => @first_name, 
                              :last_name => @last_name,
                              :phone_number => @phone_number)
  end
  
  should "have a first name" do
    @customer.first_name.should_not be_nil
  end
  
  should "have a last name" do
    @customer.last_name.should_not be_nil
  end
  
  should "have a phone number" do
    @customer.phone_number.should_not be_nil
  end
  
  should "be valid" do
    @customer.should be_valid
  end
  
  should "save" do
    @customer.save.should be_true
    @customer.errors.should be_empty
  end
end

describe "An invalid Customer" do
  before(:each) do
    @customer = Customer.new( :first_name => "golf",
                              :last_name => "walker",
                              :phone_number => "805-252-1512")
  end
  
  should "have an invalid character somewhere in their name" do
    @customer.first_name = "con*nor"
    @customer.save.should be_false
    @customer.last_name = "Mc'Innis"
    @customer.first_name = "Duncan"
    @customer.save.should be_true # apostrophes are allowed
  end
end