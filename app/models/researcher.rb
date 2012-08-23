class Researcher < ActiveRecord::Base
  has_and_belongs_to_many :publications
  belongs_to :department

  has_many :research_areas, :through => :publications
  has_many :venues, :through => :publications
  has_many :patents, :through => :research_areas
  has_many :grants, :through => :research_areas

  attr_accessible :department, :name
end
