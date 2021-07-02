class PurchaseItemsController < ApplicationController
  def index
    @purchase = Current.user.purchases.find_by(id: params[:purchase_id])
    if @purchase.nil?
      redirect_to users_path, warning: "Invalid purchase History" 
    else
      @address = @purchase.address
      @purchased_courses = @purchase.purchase_items.pluck(:price).zip(@purchase.courses)
    end
  end
end
