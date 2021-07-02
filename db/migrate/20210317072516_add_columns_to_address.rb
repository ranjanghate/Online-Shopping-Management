class AddColumnsToAddress < ActiveRecord::Migration[6.1]
  def change
    add_column :addresses, :street, :string
    add_column :addresses, :city, :string
    add_column :addresses, :state, :string
    add_column :addresses, :country, :string
    add_column :addresses, :code, :integer
    remove_column :addresses, :address
  end
end
