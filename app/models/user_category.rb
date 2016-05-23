class UserCategory < ActiveRecord::Base
  belongs_to :holder, polymorphic: true
  belongs_to :category

  before_destroy :destroy_user_subcategories

  def destroy_user_subcategories
  	holder.user_subcategories.each {|sub| sub.destroy if sub.subcategory.category.id == category.id}
  end
end
