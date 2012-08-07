class Grant < ActiveRecord::Base
  has_and_belongs_to_many :research_areas
  attr_accessible :amount, :date_awarded, :title
end
