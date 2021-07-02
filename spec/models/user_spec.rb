require 'rails_helper'

RSpec.describe User do
  user_credentials = { first_name: "first", last_name: "last", password: "password", password_confirmation: "password",
                       email: "email@mail.com", age: "20", school: "school"}
  describe "validations" do
    describe "first_name, last_name, password, email, age and school" do
      it "must be present" do
        user = described_class.new
        expect(user).to_not be_valid
        user = described_class.new(user_credentials)
        expect(user).to be_valid
      end
    end
    
    describe "first_name" do
      it "must be greater than 2" do
        user = described_class.new(user_credentials)
        user.first_name = "1"
        expect(user).to_not be_valid
        user.first_name = "first"
        expect(user).to be_valid
      end
    end
    
    describe "last_name" do
      it "must be greater than 2" do
        user = described_class.new(user_credentials)
        user.last_name = "1"
        expect(user).to_not be_valid
        user.last_name = "last"
        expect(user).to be_valid
      end
    end

    describe "password" do
      it "must be greater than 7" do
        user = described_class.new(user_credentials)
        user.password = "1"
        expect(user).to_not be_valid
        user.password = "password"
        expect(user).to be_valid
      end
    end
    
    describe "password_confirmation" do
      it "and password must match correct" do
        user = described_class.new(user_credentials)
        user.password = "password"
        user.password_confirmation = "PASSWORD"
        expect(user).to_not be_valid
        user.password = "password"
        user.password_confirmation = "password"
        expect(user).to be_valid
      end
    end

    describe "email" do
      it "must have '.' and  '@' characters " do
        user = described_class.new(user_credentials)
        user.email = "emailmailcom"
        expect(user).to_not be_valid
        user.email = "email.mailcom"
        expect(user).to_not be_valid
        user.email = "email@mail.com"
        expect(user).to be_valid
      end
    end

    describe "age" do
      it "must be an integer" do
        user = described_class.new(user_credentials)
        user.age = "10.5"
        expect(user).to_not be_valid
        user.age = "10"
        expect(user).to be_valid
      end
    end

    describe "school" do
      it "must be greater than 4" do
        user = described_class.new(user_credentials)
        user.school = "sch"
        expect(user).to_not be_valid
        user.school = "school"
        expect(user).to be_valid
      end
    end
  end

  describe "callback" do
    describe "add cart" do
      it "create cart afer user is save" do
        user = described_class.new(user_credentials)
        expect(user).to receive(:add_cart)
        user.save
      end
    end
  end
end
