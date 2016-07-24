require 'rails_helper'

RSpec.describe "sessions/new", type: :view do
  it "displays login button" do
    render

    expect(rendered).to have_button 'Đăng nhập'
  end
end
