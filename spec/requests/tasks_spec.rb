require 'rails_helper'

RSpec.describe "/tasks", type: :request do
  let(:valid_attributes) {
    { task_type: "pickup", start_time: Time.now, end_time: Time.now + 3600, 
      description: "i am a description", location: "Toronto", driver_id: Driver.create(name: "Driver 1").id }
  }

  let(:invalid_attributes) {
    { task_type: "pickup", start_time: Time.now, end_time: Time.now + 3600, 
      description: nil, location: "Toronto", driver_id: Driver.create(name: "Driver 1").id }
  }

  describe "GET /index" do
    it "renders a successful response" do
      task = Task.create!(valid_attributes)
      get driver_tasks_url(task.driver, task)
      expect(response).to be_successful
    end
  end

  describe "GET /calendar" do
    it "renders a successful response" do
      driver2 = Driver.create(name: "Driver 2")
      task1 = Task.create!(valid_attributes)
      task2 = Task.create!(task_type: "pickup", start_time: Time.now, end_time: Time.now + 3600, 
        description: "i am a description", location: "Toronto", driver_id: driver2.id)
      get tasks_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      task = Task.create!(valid_attributes)
      get driver_task_url(task.driver, task)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_task_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "render a successful response" do
      task = Task.create!(valid_attributes)
      get driver_task_url(task.driver, task)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Task" do
        expect {
          post create_task_url, params: { task: valid_attributes }
        }.to change(Task, :count).by(1)
      end

      it "redirects to the created task" do
        post create_task_url, params: { task: valid_attributes }
        expect(response).to redirect_to(tasks_url)
      end
    end

    context "with invalid parameters" do
      it "does not create a new Task" do
        expect {
          post create_task_url, params: { task: invalid_attributes }
        }.to change(Task, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post create_task_url, params: { task: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        { location: "Vancouver" }
      }

      it "updates the requested task" do
        task = Task.create!(valid_attributes)
        patch driver_task_url(task.driver, task), params: { task: new_attributes }
        task.reload
        expect(task.location).to eq("Vancouver")
      end

      it "redirects to the task" do
        task = Task.create!(valid_attributes)
        patch driver_task_url(task.driver, task), params: { task: new_attributes }
        task.reload
        expect(response).to redirect_to(driver_tasks_url)
      end
    end

    context "with invalid parameters" do
      it "renders a successful response (i.e. to display the 'edit' template)" do
        task = Task.create!(valid_attributes)
        patch driver_task_url(task.driver, task), params: { task: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested task" do
      task = Task.create!(valid_attributes)
      expect {
        delete driver_task_url(task.driver, task)
      }.to change(Task, :count).by(-1)
    end

    it "redirects to the tasks list" do
      task = Task.create!(valid_attributes)
      delete driver_task_url(task.driver, task)
      expect(response).to redirect_to(driver_tasks_url)
    end
  end
end
