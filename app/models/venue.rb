class Venue < ActiveRecord::Base
  has_many :publications

  has_many :research_areas, :through => :publications
  has_many :researchers, :through => :publications
  has_many :grants, :through => :research_areas
  has_many :patents, :through => :research_areas
  has_many :departments, :through => :researchers

  attr_accessible :name
end
