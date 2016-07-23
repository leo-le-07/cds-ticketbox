require 'rails_helper'

RSpec.describe OrderDetail, type: :model do
  let(:valid_order_detail) {FactoryGirl.build :order_detail}

  it "is valid with correct attributes" do
    expect(valid_order_detail).to be_valid
  end

  it "is invalid without order" do
    order_detail = FactoryGirl.build :order_detail, order: nil
    order_detail.valid?
    expect(order_detail.errors[:order]).to include "can't be blank"
  end

  it "is invalid without ticket" do
    order_detail = FactoryGirl.build :order_detail, ticket_type: nil
    order_detail.valid?
    expect(order_detail.errors[:ticket_type]).to include "can't be blank"
  end

  describe ".cal_total_price" do
    it "calculate correct total price" do
      valid_order_detail.save
      expect(valid_order_detail.cal_total_price).to eq(valid_order_detail.price * valid_order_detail.quantity)
    end
  end
end
