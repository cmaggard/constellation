class Link < ActiveRecord::Base
  validates_presence_of :link
  validates_presence_of :title
end
