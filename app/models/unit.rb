require_dependency "search"

class Unit < ActiveRecord::Base
  searches_on :all
  # ORM
  belongs_to :type
  belongs_to :manufacturer
  belongs_to :customer
  has_many :tickets
  
  # Validations
  validates_presence_of :serial_number
  validates_uniqueness_of :serial_number, :message => "must be a beautiful and unique snowflake."
  
  def manufacturer_type
    manufacturer.name + " " + type.name
  end
  
  def before_validation
    serial_number.upcase!
  end
end
