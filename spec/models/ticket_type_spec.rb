require 'rails_helper'

RSpec.describe TicketType, type: :model do
  let(:valid_ticket_type) { FactoryGirl.build :ticket_type }

  it "is valid with correct event_id, price, name, max_quantity, min_in_order, max_in_order" do
    expect(valid_ticket_type).to be_valid
  end

  it "is invalid without event_id" do
    ticket_type = FactoryGirl.build :ticket_type, event: nil
    ticket_type.valid?
    expect(ticket_type.errors[:event_id]).to include "can't be blank"
  end

  it "is invalid without price" do
    ticket_type = FactoryGirl.build :ticket_type, price: nil
    ticket_type.valid?
    expect(ticket_type.errors[:price]).to include "can't be blank"
  end

  it "is invalid without name" do
    ticket_type = FactoryGirl.build :ticket_type, name: nil
    ticket_type.valid?
    expect(ticket_type.errors[:name]).to include "can't be blank"
  end

  it "is invalid without max_quantity" do
    ticket_type = FactoryGirl.build :ticket_type, max_quantity: nil
    ticket_type.valid?
    expect(ticket_type.errors[:max_quantity]).to include "can't be blank"
  end

  it "is invalid without min_in_order" do
    ticket_type = FactoryGirl.build :ticket_type, min_in_order: nil
    ticket_type.valid?
    expect(ticket_type.errors[:min_in_order]).to include "can't be blank"
  end

  it "is invalid without max_in_order" do
    ticket_type = FactoryGirl.build :ticket_type, max_in_order: nil
    ticket_type.valid?
    expect(ticket_type.errors[:max_in_order]).to include "can't be blank"
  end

  it "is invalid when min_in_order is greater then max_in_order" do
    ticket_type = FactoryGirl.build :ticket_type, max_in_order: 2, min_in_order: 3
    ticket_type.valid?
    expect(ticket_type.errors[:min_in_order]).to include "min_in_order can't greater then max_in_order"
  end

  it "is invalid when max_quantity is less than min_in_order" do
    ticket_type = FactoryGirl.build :ticket_type, max_quantity: 2, min_in_order: 3
    ticket_type.valid?
    expect(ticket_type.errors[:max_quantity]).to include "max_quantity can't less then min_in_order"
  end
end
