json.name @user.name
json.id @user.id
json.loggedIn true
json.status "success"
json.set_location @user.set_current
json.lat @user.lat
json.lng @user.lng
json.rating @user.show_rating

json.categories @user.categories do |category|
	json.category category.category
	json.id category.id
	json.subcategories @user.subcategories do |subcategory|
		if subcategory.category.id == category.id
			json.category_id category.id
			json.id subcategory.id
			json.subcategory subcategory.sub
		end
	end
end

json.subcategories @user.subcategories do |subs|
	json.subcategory subs.sub
	json.id subs.id
end

json.all_categories @categories do |category|
	unless current_user.categories.any? { |c| c[:id] == category.id }
		json.category category.category
		json.id category.id
		json.subcategories []
	end
end

json.all_subcategories current_user.categories do |c|
	json.subcategories c.subcategories.each do |sub|
		unless current_user.subcategories.any? {|s| s[:id] == sub.id }
			json.category_id c.id
			json.subcategory sub.sub
			json.id sub.id
		end
	end
end



json.review_count @user.reviews.count
json.reviews @user.reviews.take(3) do |review|
	json.review truncate(review.review, :length => 65, :escape => false)
	json.rating review.rating
	unless review.anonymous
		json.writer review.writer.name
		json.writer_id review.writer.id
		json.job review.job.title
	else
		json.writer 'anonymous'
		json.job 'anonymous'
	end
end

if current_user.id == @user.id
	json.has_access true
else
	json.has_access false
end

if @user.profile_pic
	json.profile_pic @user.profile_pic
else
	json.profile_pic "http://linkhay2.vcmedia.vn/l/templates/images/no_thumb_120.png"
end

json.posts @user.posts do |p|
	json.id p.id
	json.writer p.writer.name
	json.writer_id p.writer.id
	json.post p.post
	json.created_at p.created_at
	json.like_count p.likes.count
	json.created_atn time_ago_in_words(p.created_at)
	if p.writer.profile_pic
		json.writer_pic p.writer.profile_pic
	else
		json.writer_pic "http://linkhay2.vcmedia.vn/l/templates/images/no_thumb_120.png"
	end
	json.images p.images do |c|
		json.image_url c.url
	end
	liked = p.likes.any? { |l| current_user.likes.any? { |ul| ul[:id] == l[:id]}}
	json.liked liked
	if liked 
		json.users_like current_user.likes.where(likeable: p).first
	end
	json.comment_count p.comments.count
	json.comments p.comments.order(created_at: :asc) do |comment|
		json.id comment.id
		json.comment comment.comment
		json.commenter comment.commenter.name
		json.commenter_id comment.commenter.id
		json.commenter_type comment.commenter_type

		if comment.commenter.profile_pic
			json.commenter_pic comment.commenter.profile_pic
		else
			json.commenter_pic "http://linkhay2.vcmedia.vn/l/templates/images/no_thumb_120.png"
		end		

		json.created_at comment.created_at
		json.created_atn time_ago_in_words(comment.created_at)
		json.like_count comment.likes.count
		json.likers comment.likes.take(3) do |like|
			json.name like.liker.name
			json.id like.liker.id
		end
		json.images comment.images do |c|
			json.image_url c.url
		end
		liked = comment.likes.any? { |l| current_user.likes.any? { |ul| ul[:id] == l[:id]}}
		json.liked liked
		if liked
			json.users_like comment.likes.where(liker: current_user).first
		end
		owner = current_user.comments.any? { |c| c[:id] == comment.id }
		if owner
			json.can_delete true
		else
			json.can_delete false
		end
	end
end