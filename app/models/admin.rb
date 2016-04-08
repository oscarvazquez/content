class Admin < ActiveRecord::Base
	has_secure_password
	belongs_to :business

	before_save :downcase_fields

	def downcase_fields
		self.email.downcase!
	end
end
