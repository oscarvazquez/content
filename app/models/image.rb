class Image < ActiveRecord::Base
	belongs_to :imageable, polymorphic: true

	before_destroy :update_s3

	private

	def update_s3
		unless self.file_path.blank?
			obj = S3_BUCKET.object(self.file_path)
			obj.delete
		end
	end
end
