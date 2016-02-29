require "paperclip_processors/watermark"

class Photo < ActiveRecord::Base
  belongs_to :album
  #attaches an image  that is at most 500px wide or 500x tall, applies the watermark file on top of it
  has_attached_file :image_file,
      :processors => [:watermark],
      :styles => {
        medium: "300x200>",
        thumb: "100x100>",
        :resized => {
          :geometry => "1000×1000>",
          :watermark_path => "#{Rails.root}/public/images/watermark.png",
          :position => "Center"
        }
      }

  validates_attachment_content_type :image_file, content_type: /\Aimage\/.*\z/

  before_save :generate_name

  #generate a name so that we avoid duplication if files are coming from multiple cameras

  def generate_name
    self.name = "#{album.name}-#{self.image_file_file_name}"
  end
end
