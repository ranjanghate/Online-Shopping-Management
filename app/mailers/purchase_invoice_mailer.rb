class PurchaseInvoiceMailer < ApplicationMailer
  def purchase_details_email(purchase, user)
    @user = user
    @total_price = purchase.courses.sum(:price)
    @address = purchase.address
    @total_items = purchase.purchase_items.count
    @courses = purchase.courses
    mail(to: @user.email, subject: 'eLearning courses purchase Invoice')
  end
end
