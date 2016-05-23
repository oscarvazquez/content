require 'open-uri'
class User < ActiveRecord::Base
	has_secure_password

	has_many :user_categories, as: :holder
	has_many :categories, through: :user_categories
	has_many :user_subcategories, as: :holder
	has_many :subcategories, through: :user_subcategories
	
	has_many :reviews, as: :receiver
	has_many :reviews_out, as: :writer, class_name: "Review"

	has_many :pitches, dependent: :destroy
	has_many :works, dependent: :destroy
	
	# follower information
	has_many :followRequests
	has_many :followers_requested, as: :followed, class_name: "FollowRequest"
	has_many :followers, as: :follower, class_name: "Follower"
	# has_many :businessess, through: :followers, class_name: "Follower"
	

	has_many :jobs
	has_many :messages_out, as: :sender, class_name: "Message"
	has_many :messages_in, as: :receiver, class_name: "Message"	


	has_many :comments, as: :commenter
	
	has_many :notifications_in, as: :receiver, class_name: "Notification"

	has_many :likes, as: :liker

	validates :first_name, :last_name, presence: :true, on: :create
	validates :first_name, length: {minimum: 2, too_short: "The minimum length for Last Name is 2"}
	validates :last_name, length: {minimum: 2, too_short: "The minimum length for Last Name is 2"}
	validates :password, :password_confirmation, presence: true, length: {minimum: 6, too_short: "The minimum length for Password is 6"}
	validates :email, presence: true, uniqueness: true, email: true
	
	has_many :images, as: :imageable

	has_many :posts, as: :writer
	# probably wont need this ill leave it here for now just in case
	# validates :exerpt, length: {maximum: 240, too_long: "The maximum length of exerpt is 240 characters"}
	# validates :summary, length: {minimum: 240, too_short: "The minimum length of summary is 240 characters"}
	
	before_save :downcase_fields!
	after_validation :set_login, :set_email_token, :set_user_token
	after_create :verify_email, :create_bucket
	
	def generate_auth_token
	  payload = { user_id: self.id }
	  TokenProvider.encode(payload)
	end
	
	def self.from_omniauth(auth)
		where(provider: auth.provider, id: auth.uid).first_or_initialize.tap do |user|
			user.email = auth.info.email
			user.provider = auth.provider
			user.first_name = auth.info.first_name
			user.last_name = auth.info.last_name
			user.oauth_token = auth.credentials.token
			user.password = SecureRandom.urlsafe_base64.to_s
			user.oauth_expires_at = Time.at(auth.credentials.expires_at)
			session['user_id'] = auth.id
			user.save!(validation: false)
		end
	end

	def get_notified event, initiator, message
		notifications_in.create(event: event, initiator: initiator, notification: message)
	end

	def update_password(new_password)
		update_attribute(:password, new_password)
	end
	
	def downcase_fields!
		email.downcase!
	end

	def name 
		first_name + " " + last_name
	end

	def email_verified?
		confirmation_email
	end

	def show_rating
		rating / rating_count
	end

	def set_category!(category)
		user_categories.create(category: category)
	end

	def set_subcategory!(subcategory)
		user_subcategories.create(subcategory: subcategory)
	end
  	
  	def set_resume!(resume)
  		obj = S3_BUCKET.object("#{id}/resume")
    	if obj.upload_file(resume.path, acl:'public-read')
			update_attribute(:resume, obj.public_url)
			update_attribute(:has_resume, true)
		end
	end

	def unset_resume!
		obj = S3_BUCKET.object("#{id}/resume")
		if obj.delete
			update_attribute(:resume, nil)
			update_attribute(:has_resume, false)
		end
	end

	def set_profile_pic! file
		obj = S3_BUCKET.object("profile_pictures/#{id}/#{file.original_filename}")
		if obj.upload_file(file.path, acl: 'public-read')
			update_attribute(:profile_pic, obj.public_url)
			self.images.create(file_path: "profile_pictures/#{id}/#{file.original_filename}", url: "#{obj.public_url}")
		end
	end

	def unset_profile_pic!
		update_attribute(:profile_pic, nil)
	end
 
	def set_local!(location)
		local = "https://maps.googleapis.com/maps/api/geocode/json?latlng=#{location['lat']},#{location['lng']}&key=#{ENV['GOOGLE_GEOCODE_API']}"		
		response = open(local).read
		data = JSON.parse(response)
		if data['status'] != "OVER_QUERY_LIMIT" or data['status'] != "ZERO_RESULTS"
			if data['results']
				update_attribute(:location, data["results"][0]["formatted_address"])
			end
			update_attribute(:lat, location['lat'])
			update_attribute(:lng, location["lng"])
			update_attribute(:set_current, true)
			if data['results']
				for t in data["results"][0]["address_components"]
					if t['types'][0] == 'postal_code'
						update_attribute(:zip_code, t['long_name'])
					elsif t['types'][0] == 'administrative_area_level_1'
						update_attribute(:state, t['long_name'])
					elsif t['types'][0] == 'country'
						update_attribute(:country, t['long_name'])
					elsif t['types'][0] == 'administrative_area_level_2'
						update_attribute(:city, t['long_name'])
					end		
				end
			end
		else
			return false
		end
	end

	private
	
	def set_user_token
		self.user_token = SecureRandom.urlsafe_base64.to_s
	end

	def set_email_token
		self.email_token = SecureRandom.urlsafe_base64.to_s
  	end
	
	def verify_email
		# SCHEDULER.in '5s' do
		# 	UserMailer.verify_email(self).deliver
		# end
	end

	def set_login
		if not self.login
			self.login = self.email
		end
	end

	def create_bucket
		S3_BUCKET.object('#{self.user_token}/')
	end

	def set_location(location)
		local = "https://maps.googleapis.com/maps/api/geocode/json?latlng=#{location['lat']},#{location['lng']}&key=#{ENV['GOOGLE_GEOCODE_API']}"		
		response = open(local).read
		data = JSON.parse(response)
		if data['status'] != "OVER_QUERY_LIMIT" or data['status'] != "ZERO_RESULTS"
			self.set_location = true
			self.location = data["results"][0]["formatted_address"]
			self.lat = data["results"][0]["geometry"]["location"]["lat"]
			self.lng = data["results"][0]["geometry"]["location"]["lng"]
			self.save
		else
			return false
		end
	end

end
