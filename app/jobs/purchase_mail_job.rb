class PurchaseMailJob < ApplicationJob
  queue_as :default

  def perform(purchase, user)
    PurchaseInvoiceMailer.with(user: Current.user).purchase_details_email(purchase, user).deliver_now
  end
end
