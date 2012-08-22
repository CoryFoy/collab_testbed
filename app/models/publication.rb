class Publication < ActiveRecord::Base
  has_and_belongs_to_many :researchers
  has_and_belongs_to_many :research_areas
  belongs_to :venue

  has_many :publications, :through => :research_areas
  has_many :departments, :through => :researchers
  has_many :patents, :through => :research_areas
  has_many :grants, :through => :research_areas

  attr_accessible :name, :venue_id
end
