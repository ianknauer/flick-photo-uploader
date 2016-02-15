class AlbumMailer < ApplicationMailer
  def album_ready_email(album)
    @customer = album.customer
    @album = album
    mail(to: @customer.email, subject: "Proofs from Images by Wolfgang")
  end
end
