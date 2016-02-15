class PhotosController < ApplicationController
  def new
    @album = Album.find(params[:album_id])
    @photo = Photo.new
  end

  def create
    #having both of these here allows us to connect the photos to the album through the url.
    @album = Album.find(params[:album_id])
    @photo = Photo.new(photo_params.merge!(album_id: @album.id))
    if @photo.save
      flash[:success] = "You have successfully uploaded this image"
      redirect_to album_path(@album)
    else
      flash[:error] = "Something went wrong with your upload... Please try again"
      render :new
    end
  end

  private

  def photo_params
    params.require(:photo).permit(:name, :published, :image_file)
  end
end
