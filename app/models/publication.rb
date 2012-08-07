class Publication < ActiveRecord::Base
  has_and_belongs_to_many :researchers
  has_and_belongs_to_many :research_areas

  attr_accessible :name, :venue_id
end
