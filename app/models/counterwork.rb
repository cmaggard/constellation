class Counterwork < ActiveRecord::Base
  belongs_to :technician
  
  validates_presence_of :description
end
