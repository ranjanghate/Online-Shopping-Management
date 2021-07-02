class CreatePurchases < ActiveRecord::Migration[6.1]
  def change
    create_table :purchases do |t|
      t.references :user
      t.references :address
      t.decimal :total_price

      t.timestamps
    end
  end
end
