require 'rails_helper'

RSpec.describe Course do
  describe "validations" do
    describe "name description and price" do
      it "must to be present" do
        course = described_class.new
        expect(course).to_not be_valid
        course.name = "maths"
        course.description = "this is a maths course"
        course.price = 10
        expect(course).to be_valid
      end
    end

    describe "name" do    
      it "must be greater than 4 in length" do
        course = described_class.new(description: "this is a maths course", price: 10)
        course.name = "math"
        expect(course).to_not be_valid
        course.name = "maths"
        expect(course).to be_valid
      end
    end

    describe "description" do
      it "description must be greater than 14 in length" do
        course = described_class.new(name: "maths", price: 10)
        course.description = "maths course"
        expect(course).to_not be_valid
        course.description = "this is a maths course"
        expect(course).to be_valid
      end
    end
  end
end
