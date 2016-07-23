require 'rails_helper'

RSpec.describe Order, type: :model do
  let(:valid_order) {FactoryGirl.build :order}
  it "is valid with correct attributes" do
    expect(valid_order).to be_valid
    expect(valid_order.save).to be true
  end

  it "is invalid without customer name" do
    order = FactoryGirl.build :order, name: nil
    order.valid?
    expect(order.errors[:name]).to include "can't be blank"
  end

  it "is invalid without customer email" do
    order = FactoryGirl.build :order, email: nil
    order.valid?
    expect(order.errors[:email]).to include "can't be blank"
  end

  it "is invalid without customer phone" do
    order = FactoryGirl.build :order, phone: nil
    order.valid?
    expect(order.errors[:phone]).to include "can't be blank"
  end

  it "is invalid with a wrong email format" do
    order = FactoryGirl.build :order, email: "myemail.com"
    order.valid?
    expect(order.errors[:email]).to include "Email format is not correct"
  end

  it "is invalid when order_number has already been taken" do
    allow_any_instance_of(Order).to receive(:generate_order_number).and_return("ABC")
    order_a = FactoryGirl.build :order
    order_b = FactoryGirl.build :order
    order_a.save
    expect(order_b.save).to be false
    expect(order_b.errors[:order_number]).to include "has already been taken"
  end
end
