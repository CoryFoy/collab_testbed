class Researcher < ActiveRecord::Base
  has_and_belongs_to_many :publications
  belongs_to :department

  attr_accessible :department, :name
end