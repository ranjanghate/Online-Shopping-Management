require 'rails_helper'

RSpec.describe Purchase do
  user_credentials = { first_name: "first", last_name: "last", password: "password", password_confirmation: "password",
                       email: "email@mail.com", age: "20", school: "school"}
  describe "callback" do
    describe "destroy cart items" do
      it "after purchase is made" do
        user = User.new(user_credentials)
        purchase = user.purchases.new
        expect(purchase).to receive(:destroy_cart)
        purchase.save
      end
    end
  end
end
