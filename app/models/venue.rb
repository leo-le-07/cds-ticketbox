class Venue < ActiveRecord::Base
  belongs_to :region
  has_one :event
end
