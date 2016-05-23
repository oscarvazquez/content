class Subcategory < ActiveRecord::Base
	belongs_to :category
	has_many :user_subcategories, dependent: :destroy
	has_many :users, through: :user_subcategories
	has_many :business_subcategories, dependent: :destroy
	has_many :businesses, through: :business_subcategories
	has_many :posts
	
	validates :category, presence: true
	validates :sub, presence: true
end
