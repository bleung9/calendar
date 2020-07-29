require 'rails_helper'

RSpec.describe "drivers/index", type: :view do
  before(:each) do
    assign(:drivers, [
      Driver.create!(
        name: "Name"
      ),
      Driver.create!(
        name: "Name"
      )
    ])
  end

  it "renders a list of drivers" do
    render
    assert_select "tr>td", text: "Name".to_s, count: 2
  end
end
