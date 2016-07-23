class OrderDetail < ActiveRecord::Base
  before_create :cal_total_price

  belongs_to :order
  belongs_to :ticket_type

  validates_presence_of :order, :ticket_type

  def cal_total_price
    self.total_price = self.price * self.quantity
  end
end
