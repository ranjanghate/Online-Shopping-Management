class CartItemsController < ApplicationController
  before_action :user_signed_in?
  before_action :authenticate_user!, only: %i(index destroy)
  before_action :set_cart_item, only: %i(destroy)  

  def index
    @course_cart_items = Current.cart.courses.zip(Current.cart.cart_items.pluck(:id))
  end

  def create
    @cart_item = CartItem.new(cart_id: Current.cart.id, course_id: params[:course_id])
    if @cart_item.save
      redirect_to courses_path, info: "Added to cart"
    else
      redirect_to course_path(params[:course_id]), info: "Already added to cart "
    end
  end

  def destroy
    @cart_item.destroy
    respond_to do |format|
      format.html { redirect_to user_cart_items_path(Current.user), info: "Cart item removed" }
      format.json { head :no_content }
      format.js   { flash.now[:danger] = "Course removed from cart" }
    end
  end

  private
  def set_cart_item
    @cart_item = Current.cart.cart_items.find_by(id: params[:id])
    redirect_to user_cart_items_path(Current.user), warning: "You are trying to access invalid Cart Item" if @cart_item.blank?
  end
end
