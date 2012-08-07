class ResearchArea < ActiveRecord::Base
  has_and_belongs_to_many :grants
  has_and_belongs_to_many :patents
  has_and_belongs_to_many :publications
  attr_accessible :name
end
