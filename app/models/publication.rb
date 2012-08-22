class Publication < ActiveRecord::Base
  has_and_belongs_to_many :researchers
  has_and_belongs_to_many :research_areas
  belongs_to :venue

  attr_accessible :name, :venue_id
end
