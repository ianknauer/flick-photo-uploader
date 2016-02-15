class AddContactedAndReadyToContactToAlbums < ActiveRecord::Migration
  def change
    add_column :albums, :published, :boolean, default: false
  end
end
