class AlbumsController < ApplicationController
  before_action :set_album, only: [:edit, :update]
  before_action :decorated_set_album, only: [:show, :index]

  def show
  end

  def new #albums are always created as a child of a customer, so we pass the customer_id in when we create a new one.
    @customer = Customer.find(params[:customer_id])
    @album = Album.new
  end

  def create
    @customer = Customer.find(params[:customer_id]) #find customer from customer/:id
    @album = Album.new(album_params.merge!(customer_id: @customer.id)) #merge customer_id into album info
    if @album.save
      flash[:success] = "You have successfully created this album"
      redirect_to album_path(@album)
    else
      flash[:error] = "something went wrong with your submission, try again"
      render :new
    end
  end

  def edit
  end

  def update
    if @album.update(album_params) #this loops allows the user to upload files multiple times to the same album
      if !params[:photos].nil? #checks if there are actually photos in the edit
        params[:photos]['image_file'].each do |a| #loops through the photos attached to the album
          @photo = @album.photos.create!(image_file: a, album_id: @album.id) #creates photo and attaches it to our album
        end
        flash[:success] = "You have uploaded the files to this album"
      end
      if @album.published? #this is the checkbox to get the files up to flickr
        UploadJob.perform_later @album
        #upload = PhotosToFlickr.new(@album).upload_photos_and_create_album #This calls the service, keeps all of the logic out of the controller
        #if upload.successful?
        #  @album.url = upload.url
        #  @album.save #if successful we attach the flickr url to the album
        #end
      end
      if @album.contacted? #this is the last check box to get the emial to the customer
        AlbumMailer::album_ready_email(@album).deliver #this is a mailer that send a pre-written email with a link to the file on flickr
      end
      redirect_to album_path(@album)
    else #error path
      flash[:error] = "something went wrong with your submission, try again"
      render :edit
    end
  end

  private

  def album_params
    params.require(:album).permit(:name, :published, :contacted)
  end

  def set_album #i'm using a decorator here to show whether a customer has been contacted about an album or not
    @album = Album.find(params[:id])
  end

  def decorated_set_album #i'm using a decorator here to show whether a customer has been contacted about an album or not
    @album = AlbumDecorator.decorate(Album.find(params[:id]))
  end
end
