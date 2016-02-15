class AddContactedToAlbum < ActiveRecord::Migration
  def change
    add_column :albums, :contacted, :boolean, default: false, null: false
  end
end
