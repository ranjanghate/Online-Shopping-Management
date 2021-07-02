class ChangeDefaultAddressIdToReference < ActiveRecord::Migration[6.1]
  def change
    add_foreign_key :users, :addresses, column: :default_address_id
  end
end
