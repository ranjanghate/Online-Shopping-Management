require 'rails_helper'

RSpec.describe Address do
  user = User.create(first_name: "temp", last_name: "temp",
                     email: "temp@gmail.com", password: "password", age: "10", school: "school")
  address_credentials = { street: "3 Edgar Buildings", city: "bath city", state: "somerset", country: "england", code: 14306 }
  describe "validations" do
    describe "user" do
      it "must be present" do
        address = described_class.new(address_credentials)
        expect(address).to_not be_valid
        address = user.addresses.new(address_credentials)
        expect(address).to be_valid
      end
    end
    
    describe "street city state country and code" do
      it "must be present" do
        address = user.addresses.new
        expect(address).to_not be_valid
        address = user.addresses.new(address_credentials)
        expect(address).to be_valid  
      end
    end

    describe "street" do
      it "must be greater than 4" do
        address = user.addresses.new(address_credentials)
        address.street = "bath"
        expect(address).to_not be_valid
        address.street = "3 Edgar Buildings"
        expect(address).to be_valid
      end
    end

    describe "city" do
      it "must be greater than 4" do
        address = user.addresses.new(address_credentials)
        address.city = "bath"
        expect(address).to_not be_valid
        address.city = "bath city"
        expect(address).to be_valid
      end
    end

    describe "state" do
      it "must be greater than 2" do
        address = user.addresses.new(address_credentials)
        address.state = "st"
        expect(address).to_not be_valid
        address.state= "somerset"
        expect(address).to be_valid
      end
    end

    describe "country" do
      it "must be greater than 2" do
        address = user.addresses.new(address_credentials)
        address.country = "us"
        expect(address).to_not be_valid
        address.country= "england"
        expect(address).to be_valid
      end
    end

    describe "code" do
      it "must be and integer" do
        address = user.addresses.new(address_credentials)
        address.code= 14306.45
        expect(address).to_not be_valid
        address.code = "14306"
        expect(address).to be_valid
        address.code= 14306
        expect(address).to be_valid
      end
    end
  end
end
