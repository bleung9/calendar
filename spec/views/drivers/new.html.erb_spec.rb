require 'rails_helper'

RSpec.describe "drivers/new", type: :view do
  before(:each) do
    assign(:driver, Driver.new(
      name: "MyString"
    ))
  end

  it "renders new driver form" do
    render

    assert_select "form[action=?][method=?]", drivers_path, "post" do

      assert_select "input[name=?]", "driver[name]"
    end
  end
end
