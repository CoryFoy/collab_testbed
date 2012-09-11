class Patent < ActiveRecord::Base
  has_and_belongs_to_many :research_areas

  has_many :publications, :through => :research_areas
  has_many :grants, :through => :research_areas
  has_many :researchers, :through => :publications
  has_many :venues, :through => :publications
  has_many :departments, :through => :researchers

  attr_accessible :title
end
