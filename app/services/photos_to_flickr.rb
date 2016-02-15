class PhotosToFlickr
  attr_reader :error_message, :url #allows us to access these two outside of the class

  def initialize(album)
    @album = album
  end

  def upload_photos_and_create_album
    if @album.valid? #making sure what we're passing is actually a valid object
      photos = [] #create an array to put the Flickr photo id's into
      @album.photos.each do |photo| #rolling through the array of photos in an album
         picture = FlickrWrapper::Photo.create( #working with the FLickr Wrapper i wrote to create a photo on flickr, passing in 4 options)
          title: "#{@album.name} - #{photo.id}",
          description: "Please contact Images by Wolfgang at 604-833-6439 if you have any questions or to order your photographs.",
          name: "#{photo.image_file_file_name}",
          id: "0#{photo.id}",
        )
        photos << picture #adds the photo id returned to the array
      end
      album_id = FlickrWrapper::Album.create( #Working with FLickrWrapper to create album and records it's id for later use
        title: "#{@album.name}",
        primary_photo_id: photos[0] #Flickr albums can't be created without a primary photo or this would have been done before photos were uploaded
      )
      photos.shift #removing the first photo that was used for primary_photo_id because it throws an error stating it's already in album
      photos.each do |photo|
        FlickrWrapper::Album.add_image(#Working with FlickrWrapper to add the images into the album
          photoset_id: "#{album_id.id}",
          photo_id: "#{photo}"
        )
      end
      @status = :success #sets the status as success if everthing worked
      @url = "https://www.flickr.com/photos/52347441@N03/albums/#{album_id.id}" #returns the url to be used in the controller
      self #returns self so we can look up url & status
    else
      @status = :failed
      @error_message = "this process failed"
    end
  end

  def successful?
    @status == :success
  end
end
