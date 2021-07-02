class CreatePurchaseItems < ActiveRecord::Migration[6.1]
  def change
    create_table :purchase_items do |t|
      t.references :purchase
      t.references :course
      t.decimal :price

      t.timestamps
    end
  end
end
