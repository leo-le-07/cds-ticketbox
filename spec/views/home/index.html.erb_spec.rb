require 'rails_helper'

RSpec.describe "home/index", type: :view do
  it "display search box input" do
    @events = Event.all
    render

    expect(rendered).to have_text 'Khám phá các sự kiện nổi bật'
  end
end
