class SubcategoriesController < ApplicationController

	def destroy
		UserSubcategory.where(subcategory_id: params[:id], holder: current_user).first.destroy
		render :json => {message: "success"}
	end

	def create
		params[:subcategories].each do |c|
			current_user.set_subcategory!(Subcategory.find(c[:id]))
		end

		render :json => {message: "success"}
	end

end