 require 'rails_helper'

RSpec.describe "/drivers", type: :request do
  let(:valid_attributes) {
    { name: "Driver 1" }
  }

  let(:invalid_attributes) {
    { name: nil }
  }

  describe "GET /index" do
    it "renders a successful response" do
      Driver.create!(valid_attributes)
      get drivers_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      driver = Driver.create!(valid_attributes)
      get driver_url(driver)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_driver_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "render a successful response" do
      driver = Driver.create!(valid_attributes)
      get edit_driver_url(driver)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Driver" do
        expect {
          post drivers_url, params: { driver: valid_attributes }
        }.to change(Driver, :count).by(1)
      end

      it "redirects to the created driver" do
        post drivers_url, params: { driver: valid_attributes }
        expect(response).to redirect_to(driver_url(Driver.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Driver" do
        expect {
          post drivers_url, params: { driver: invalid_attributes }
        }.to change(Driver, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post drivers_url, params: { driver: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        { name: "Driver 2" }
      }

      it "updates the requested driver" do
        driver = Driver.create!(valid_attributes)
        patch driver_url(driver), params: { driver: new_attributes }
        driver.reload
        expect(driver.name).to eq("Driver 2")
      end

      it "redirects to the driver" do
        driver = Driver.create!(valid_attributes)
        patch driver_url(driver), params: { driver: new_attributes }
        driver.reload
        expect(response).to redirect_to(driver_url(driver))
      end
    end

    context "with invalid parameters" do
      it "renders a successful response (i.e. to display the 'edit' template)" do
        driver = Driver.create!(valid_attributes)
        patch driver_url(driver), params: { driver: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested driver" do
      driver = Driver.create!(valid_attributes)
      expect {
        delete driver_url(driver)
      }.to change(Driver, :count).by(-1)
    end

    it "redirects to the drivers list" do
      driver = Driver.create!(valid_attributes)
      delete driver_url(driver)
      expect(response).to redirect_to(drivers_url)
    end
  end
end
