class PurchaseItem < ApplicationRecord
  belongs_to :purchase
  belongs_to :course
end
