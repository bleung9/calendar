require 'rails_helper'

RSpec.describe Task, type: :model do

  let(:driver) { Driver.create(name: "John Doe") }
  let(:task) { Task.new(task_type: "pickup", start_time: Time.now, end_time: Time.now + 3600, 
    description: "i am a description", location: "Toronto", driver: driver) }

  describe "validations on task model" do
    it "is valid if it has all attributes and passes all validations" do
      Task.create(task_type: "pickup", start_time: Time.now + 3601, end_time: Time.now + 3700, 
        description: "i am a description", location: "Toronto", driver: driver)
        
      expect(task.valid?).to eq(true)
    end

    it "is invalid if it doesn't have a driver" do
      task.driver = nil

      expect(task.valid?).to eq(false)
    end

    it "is invalid if it doesn't have a task type" do
      task.task_type = nil

      expect(task.valid?).to eq(false)
    end

    it "is invalid if it doesn't have a valid task type" do
      task.task_type = "invalid task type"

      expect(task.valid?).to eq(false)
    end

    it "is invalid if it doesn't have a start time" do
      task.start_time = nil

      expect(task.valid?).to eq(false)
    end

    it "is invalid if it doesn't have an end time" do
      task.end_time = nil

      expect(task.valid?).to eq(false)
    end

    it "is invalid if its start time is later or the same as its end time (#start_before_end)" do
      task.start_time = Time.now + 10
      task.end_time = Time.now
      expect(task.valid?).to eq(false)

      task.start_time = task.end_time = Time.now
      expect(task.valid?).to eq(false)
    end

    it "is invalid if it overlaps with another task (#no_overlap)" do
      start_time = Time.now - 100
      end_time = Time.now + 100
      Task.create(task_type: "pickup", start_time: start_time, end_time: end_time, 
        description: "i am a description", location: "Toronto", driver: driver)
      
      expect(task.valid?).to eq(false)
      expect(task.errors.messages[:start_time].first). to eq("or end time overlaps with an existing task. Perhaps #{(end_time).strftime("%B %d %Y %I:%M%p")} to #{(end_time + 3600).strftime("%B %d %Y %I:%M%p")} is better?")
    end

    it "is invalid if it doesn't have a description" do
      task.description = nil

      expect(task.valid?).to eq(false)
    end

    it "is invalid if it doesn't have a location" do
      task.location = nil

      expect(task.valid?).to eq(false)
    end
  end

end
