require_dependency "search"

class Customer < ActiveRecord::Base
  searches_on :all
  
  # Relationships
  has_many :tickets
  has_many :units
  
  # Validations
  validates_presence_of :first_name, :last_name, :phone_number, 
                        :message => "is required."
  validates_format_of :first_name, :last_name, 
                      :with => /^[A-Za-z\-\']+$/, 
                      :message => "is missing or invalid."
  validates_format_of :phone_number, 
                      :with => /^\d{3}-\d{3}-\d{4}(x\d+)?$/, 
                      :message => "must be in the format ###-###-#### or ###-###-####x####"
  validates_uniqueness_of :phone_number, 
                          :scope => [:last_name, :first_name], 
                          :message => "is not unique to this name.  Check the list below for the existing "
                                      "customer and use that one.  It's easier.  Trust me."
  
  def first_last_name
    first_name + " " + last_name
  end
  
  def last_first_name
    last_name + ", " + first_name
  end
  
  def displayable_phone
    ret = phone_number
    unless alt_phone_number.nil?
      ret += " / #{alt_phone_number}" unless alt_phone_number.empty?
    end
    ret
  end
  
  def before_validation
    first_name.strip! unless first_name.nil?
    last_name.strip! unless last_name.nil?
    phone_number.strip! unless phone_number.nil?
    department.strip! unless department.nil?
    email_address.strip! unless email_address.nil?
    alt_phone_number.strip! unless alt_phone_number.nil?
  end
end
