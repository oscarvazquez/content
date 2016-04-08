class Comment < ActiveRecord::Base
	belongs_to :commenter, polymorphic: true
	belongs_to :commenteable, polymorphic: true
end
