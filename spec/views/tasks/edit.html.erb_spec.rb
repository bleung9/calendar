require 'rails_helper'

RSpec.describe "tasks/edit", type: :view do
  before(:each) do
    @task = assign(:task, Task.create!(
      type: "",
      description: "MyString",
      location: "MyString"
    ))
  end

  it "renders the edit task form" do
    render

    assert_select "form[action=?][method=?]", driver_task_path(@task), "post" do

      assert_select "input[name=?]", "task[type]"

      assert_select "input[name=?]", "task[description]"

      assert_select "input[name=?]", "task[location]"
    end
  end
end
