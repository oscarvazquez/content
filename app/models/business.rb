require 'open-uri'
class Business < ActiveRecord::Base
  	has_secure_password

	has_many :business_categories
	has_many :business_subcategories
	has_many :categories, through: :business_categories
	has_many :subcategories, through: :business_subcategories
	has_many :reviews, as: :receiver
	has_many :admins, dependent: :destroy
	has_many :pitches, dependent: :destroy
	has_many :followers, dependent: :destroy
	has_many :users, through: :followers
	has_many :messages, dependent: :destroy, as: :sender
	has_many :messages_out, as: :receiver, source: :messages, class_name: "Message"
	has_many :requests
	has_many :notifications_in, as: :receiver, class_name: "Notification"

	# this association is not working figure out how to make two associations to the same class
	has_many :reviews_out, as: :writer, class_name: "Review"

	validates :name, :zip_code, :city, :country, :street_address, presence: true
	validates :email, presence: true, uniqueness: true, email: true
	
	before_create :set_login, :set_email_token
	after_create :verify_email, :set_admin
	before_save :downcase_fields

	def downcase_fields
		email.downcase!
	end

	def email_verified?
		confirmation_email
	end

	def show_rating
		rating / rating_count
	end

	def set_category!(category)
		business_categories.create(category: category)
	end

	def set_subcategory!(subcategory)
		business_subcategories.create(subcategory: subcategory)
	end
  	
	private 

	def set_email_token
		self.email_token = SecureRandom.urlsafe_base64.to_s
  	end

  	def set_admin
  		admin = self.admins.new
  		admin.email = self.email
  		admin.business = self
  		admin.password = self.password
  		admin.save
  	end
	
	def verify_email
		UserMailer.verify_email(self).deliver
	end

	def set_login
		if not self.login
			self.login = self.email
		end
	end

	def set_location
		local = [self.street_address, self.city, self.state, self.country].compact.join('+ ')
		men = "https://maps.googleapis.com/maps/api/geocode/json?address=#{local}&&components=country:#{self.country}|postal_code:#{self.zip_code}&key=AIzaSyCJHq8Qnb5ltxlg3ZPDD7i7_69kjGXnieA"		
		response = open(men).read
		data = JSON.parse(response)
		if data['status'] != "OVER_QUERY_LIMIT"
			self.location = data["results"][0]["formatted_address"]
			self.lat = data["results"][0]["geometry"]["location"]["lat"]
			self.lng = data["results"][0]["geometry"]["location"]["lng"]
			self.save
		end
	end
end
