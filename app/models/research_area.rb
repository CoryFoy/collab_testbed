class ResearchArea < ActiveRecord::Base
  has_and_belongs_to_many :grants
  has_and_belongs_to_many :patents
  has_and_belongs_to_many :publications

  has_many :researchers, :through => :publications
  has_many :research_areas, :through => :publications
  has_many :venues, :through => :publications
  has_many :departments, :through => :researchers

  attr_accessible :name
end
