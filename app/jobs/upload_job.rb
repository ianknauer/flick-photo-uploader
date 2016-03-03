class UploadJob < ActiveJob::Base
  queue_as :default

  def perform(album)
    upload = PhotosToFlickr.new(album)
    upload.upload_photos_and_create_album
    album.update!(url: upload.url)
  end
end
