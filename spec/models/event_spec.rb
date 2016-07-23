require 'rails_helper'

RSpec.describe Event, type: :model do
  let(:valid_event) { FactoryGirl.build :event }

  it "is valid with correct owner, name, vanue, category, starts, ends, description" do
    expect(valid_event).to be_valid
    expect(valid_event.save).to be true
  end

  it "is invalid without starts at" do
    event = FactoryGirl.build :event, starts_at: nil
    event.valid?
    expect(event.errors[:starts_at]).to include "can't be blank"
  end

  it "is invalid without ends at" do
    event = FactoryGirl.build :event, ends_at: nil
    event.valid?
    expect(event.errors[:ends_at]).to include "can't be blank"
  end

  it "is invalid without name" do
    event = FactoryGirl.build :event, name: nil
    event.valid?
    expect(event.errors[:name]).to include "can't be blank"
  end

  it "is invalid without venue" do
    event = FactoryGirl.build :event, venue: nil
    event.valid?
    expect(event.errors[:venue]).to include "can't be blank"
  end

  it "is invalid without category" do
    event = FactoryGirl.build :event, category: nil
    event.valid?
    expect(event.errors[:category]).to include "can't be blank"
  end

  it "is invalid without description" do
    event = FactoryGirl.build :event, extended_html_description: nil
    event.valid?
    expect(event.errors[:extended_html_description]).to include "can't be blank"
  end

  it "is draft as default after creating" do
    valid_event.save
    expect(valid_event.status).to eq 1
  end

  it "is invalid when starts time after ends time" do
    event = FactoryGirl.build :event, starts_at: 3.days.from_now, ends_at: 2.days.from_now
    event.valid?
    expect(event.errors[:ends_at]).to include "ends_at can't be before starts_at"
  end

  it "is invalid when starts time in past" do
    event = FactoryGirl.build :event, starts_at: 2.days.ago
    event.valid?
    expect(event.errors[:starts_at]).to include "starts_at can't be in past"
  end

  describe ".draft?" do
    it "return true when status is draft" do
      valid_event.save
      expect(valid_event.draft?).to be true
    end

    it "return false when status is not draft" do
      valid_event.status = 2
      valid_event.save
      expect(valid_event.draft?).to be false
    end
  end

end
