require 'rails_helper'

RSpec.describe Driver, type: :model do
  let(:driver) { Driver.new(name: "John Doe") }

  describe "validations on driver model" do
    it "is valid if it has all necessary attributes" do

      expect(driver.valid?).to eq(true)
    end

    it "is invalid if it doesn't have a name" do
      driver.name = nil
      
      expect(driver.valid?).to eq(false)
    end

    it "is invalid if new driver's name is the same as an existing driver's" do
      Driver.create!(name: "John Doe")
      
      expect(driver.valid?).to eq(false)
    end
  end
end
