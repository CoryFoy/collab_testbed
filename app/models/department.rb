class Department < ActiveRecord::Base
  has_many :researchers

  has_many :publications, :through => :researchers
  has_many :research_areas, :through => :publications
  has_many :venues, :through => :publications
  has_many :grants, :through => :research_areas
  has_many :patents, :through => :research_areas

  attr_accessible :name
end
