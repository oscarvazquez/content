class UserSubcategory < ActiveRecord::Base
	belongs_to :holder, polymorphic: true
	belongs_to :subcategory
end
