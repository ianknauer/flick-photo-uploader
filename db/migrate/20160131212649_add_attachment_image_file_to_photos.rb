class AddAttachmentImageFileToPhotos < ActiveRecord::Migration
  def self.up
    change_table :photos do |t|
      t.attachment :image_file
    end
  end

  def self.down
    remove_attachment :photos, :image_file
  end
end
