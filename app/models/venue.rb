class Venue < ActiveRecord::Base
  belongs_to :region
  validates_uniqueness_of :name

  accepts_nested_attributes_for :region
end
