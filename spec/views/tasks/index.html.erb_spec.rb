require 'rails_helper'

RSpec.describe "tasks/index", type: :view do
  before(:each) do
    assign(:tasks, [
      Task.create!(
        type: "Type",
        description: "Description",
        location: "Location"
      ),
      Task.create!(
        type: "Type",
        description: "Description",
        location: "Location"
      )
    ])
  end

  it "renders a list of tasks" do
    render
    assert_select "tr>td", text: "Type".to_s, count: 2
    assert_select "tr>td", text: "Description".to_s, count: 2
    assert_select "tr>td", text: "Location".to_s, count: 2
  end
end
