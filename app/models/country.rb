class Country < ActiveRecord::Base
  has_many :ratings
  validates_presence_of :name
end
