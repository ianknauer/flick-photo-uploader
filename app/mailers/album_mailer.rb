class AlbumMailer < ApplicationMailer
  def album_ready_email(album)
    @customer = album.customer
    @album = album
    mail(to: @customer.email, subject: "Proofs from Images by Wolfgang")
    attachments['price_list.pdf'] = File.read(Rails.public_path.join("documents/price_list.pdf"))
  end
end
