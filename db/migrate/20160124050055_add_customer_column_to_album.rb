class AddCustomerColumnToAlbum < ActiveRecord::Migration
  def change
    add_column :albums, :customer_id, :integer
  end
end
