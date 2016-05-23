class Comment < ActiveRecord::Base
	belongs_to :commenter, polymorphic: true
	belongs_to :commentable, polymorphic: true

	has_many :likes, as: :likeable

	after_create :notify

	has_many :images, as: :imageable, dependent: :destroy

	def notify
		if commentable_type == "Review" && commenter != commentable.writer
			message = "responded to your review: " + comment
			commentable.writer.get_notified self, commenter, message 
		end
	end

	def upload_file file
		if file
			path = "comments/#{self.id}/#{file.original_filename}"
			obj = S3_BUCKET.object(path)
			obj.upload_file(file.path, acl: 'public-read')
			self.images.create(file_path: path, url: obj.public_url)
		end
	end

end
