class CategoriesController < ApplicationController

	def destroy
		UserCategory.where(category_id: params[:id], holder: current_user).first.destroy
		@subcategories = Category.find(params[:id]).subcategories
		render :json => {message: "success", subcategories: @subcategories.to_json}
	end

	def create
		@new_subs = []
		params[:categories].each do |c|
			cat = Category.find(c[:id])
			current_user.set_category!(Category.find(c[:id]))
			cat.subcategories.each {|n| @new_subs << n}
		end
	end

end