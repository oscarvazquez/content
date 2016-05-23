class Post < ActiveRecord::Base
  belongs_to :subcategory
  belongs_to :writer, polymorphic: true
  has_many :likes, as: :likeable
  has_many :comments, as: :commentable
  has_many :images, as: :imageable, dependent: :destroy

  	def upload_file file
		if file
			path = "posts/#{self.id}/#{file.original_filename}"
			obj = S3_BUCKET.object(path)
			obj.upload_file(file.path, acl: 'public-read')
			self.images.create(file_path: path, url: obj.public_url)
		end
	end

end
