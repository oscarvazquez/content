class Category < ActiveRecord::Base
	has_many :user_categories, dependent: :destroy
	has_many :users, through: :user_categories
	has_many :business_categories, dependent: :destroy
	has_many :businesses, through: :business_categories
	has_many :subcategories, dependent: :destroy
	has_many :requests
	
	validates :category, presence: true

	def self.get_users
		self.users.where(active: true).order(rating: :desc, jobs_completed: :desc)
	end

	def self.get_biz
		self.businesses.where(active: true).order(rating: :desc, jobs_completed: :desc)
	end
end
