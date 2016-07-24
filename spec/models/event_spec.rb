require 'rails_helper'

RSpec.describe Event, type: :model do
  let(:venue) {Venue.first}
  let(:category) {Category.first}
  let(:user) {User.first}

  it "is valid with correct owner, name, vanue, category, starts, ends, description" do
    event = Event.new(name: "Đại hội võ lâm 4", owner: user, venue_id: venue.id, category_id: category.id, extended_html_description: "<p>New event</p>")
    expect(event).to be_valid
  end

  describe ".draft?" do
    it "return true when status is draft" do
      event = Event.new(name: "Đại hội võ lâm 3", owner: user, venue_id: venue.id, category_id: category.id, extended_html_description: "<p>New event</p>")
      event.save
      expect(event.draft?).to be true
    end

    it "return false when status is not draft" do
      event = Event.new(name: "Đại hội võ lâm 3", owner: user, venue_id: venue.id, category_id: category.id, extended_html_description: "<p>New event</p>", status: 2)
      event.save
      expect(event.draft?).to be false
    end
  end

  # it "is invalid without name" do
  #   event = FactoryGirl.build :event, name: nil
  #   event.valid?
  #   expect(event.errors[:name]).to include "can't be blank"
  # end

  # it "is invalid without venue" do
  #   event = FactoryGirl.build :event, venue: nil
  #   event.valid?
  #   expect(event.errors[:venue]).to include "can't be blank"
  # end

  # it "is invalid without category" do
  #   event = FactoryGirl.build :event, category: nil
  #   event.valid?
  #   expect(event.errors[:category]).to include "can't be blank"
  # end

  # it "is invalid without description" do
  #   event = FactoryGirl.build :event, extended_html_description: nil
  #   event.valid?
  #   expect(event.errors[:extended_html_description]).to include "can't be blank"
  # end

  # it "is draft as default after creating" do
  #   event = Event.new(name: "Đại hội võ lâm 2", owner: user, venue_id: venue.id, category_id: category.id, extended_html_description: "<p>New event</p>")
  #   event.save
  #   expect(event.status).to eq 1
  # end

  # it "is invalid when starts time after ends time" do
  #   event = FactoryGirl.build :event, starts_at: 3.days.from_now, ends_at: 2.days.from_now
  #   event.valid?
  #   expect(event.errors[:ends_at]).to include "ends_at can't be before starts_at"
  # end

  # it "is invalid when starts time in past" do
  #   event = FactoryGirl.build :event, starts_at: 2.days.ago
  #   event.valid?
  #   expect(event.errors[:starts_at]).to include "starts_at can't be in past"
  # end

  # describe ".draft?" do
  #   it "return true when status is draft" do
  #     event = Event.new(name: "Đại hội võ lâm 2", owner: user, venue_id: venue.id, category_id: category.id, extended_html_description: "<p>New event</p>")
  #     event.save
  #     expect(event.draft?).to be true
  #   end

  #   it "return false when status is not draft" do
  #     event = Event.new(name: "Đại hội võ lâm 2", owner: user, venue_id: venue.id, category_id: category.id, extended_html_description: "<p>New event</p>", status: 2)
  #     event.save
  #     expect(event.draft?).to be false
  #   end
  # end

  # describe "#search_by_name" do
  #   past_event = FactoryGirl.build :event, name: "Việt nam hội nghị 5", starts_at: 22.days.ago, ends_at: 10.days.ago
  #   past_event.save(validate: false)
  #   event_a = FactoryGirl.build(:event, name: "Đua xe mở rộng 5", starts_at: 22.days.from_now, ends_at: 25.days.from_now)
  #   event_b = FactoryGirl.build(:event, name: "Hội code đua 5", starts_at: 23.days.from_now, ends_at: 26.days.from_now)

  #   it "doesn't return past events" do
  #     events = Event.search_by_name("hoi")
  #     expect(events).to match_array([event_b])
  #   end

  #   it "return all current and future events order by starts at time ascending when the name is empty"

  #   it "return "

  #   it "return events which have name include name search"

  #   it "return empty when no events name match name search"
  # end

end
