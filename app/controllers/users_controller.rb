class UsersController < ApplicationController
  def index
    @addresses = Current.user.addresses.limit(5)
    @courses = Current.cart.courses.limit(5)
    @purchases = Current.user.purchases.limit(5)
  end
end
