module FlickrWrapper #these all operate individually, which means we're connecting to the flickr API for each file. 
  class Photo
    attr_reader :response #makes response available
    def self.create(options={}) #uploads photo to FLickr via flickraw gem, takes the four options passed in through the service
      response = flickr.upload_photo Rails.public_path.join("system/photos/image_files/000/000/#{options[:id]}/resized/#{options[:name]}"),
      title: options[:title],
      description: options[:description]
    end
  end

  class Album
    attr_reader :response #makes respones available
    def self.create(options={}) #creates album on flickr and adds a primary photo.
      photoset = flickr.photosets.create(
        :title => "#{options[:title]}",
        :primary_photo_id => "#{options[:primary_photo_id]}"
      )
    end
    def self.add_image(options={}) #adds an image to the photoset that is listed.
      flickr.photosets.addPhoto photoset_id: "#{options[:photoset_id]}", photo_id: "#{options[:photo_id]}"
    end
  end
end
