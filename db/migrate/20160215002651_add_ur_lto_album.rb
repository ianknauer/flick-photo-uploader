class AddUrLtoAlbum < ActiveRecord::Migration
  def change
    add_column :albums, :url, :string
  end
end
