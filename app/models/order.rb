class Order < ActiveRecord::Base
  belongs_to :event
  has_many :order_details

  accepts_nested_attributes_for :order_details
end
