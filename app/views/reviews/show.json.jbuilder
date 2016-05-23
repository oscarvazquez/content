json.name @user.name
json.id @user.id
json.rating @user.show_rating
json.rating_5 @user.reviews.where('rating >= 5').count
json.rating_4 @user.reviews.where('rating >= 4 and rating < 5').count
json.rating_3 @user.reviews.where('rating >= 3 and rating < 4').count
json.rating_2 @user.reviews.where('rating >= 2 and rating < 3').count
json.rating_1 @user.reviews.where('rating >= 0 and rating < 2').count


json.review_count @user.reviews.count
json.reviews @user.reviews.take(10) do |review|
	json.id review.id
	json.review review.review
	json.rating review.rating
	json.like_count review.likes.count
	json.created_at review.created_at
	json.created_atn time_ago_in_words(review.created_at)
	json.writer review.writer.name
	json.writer_id review.writer.id
	if review.writer.profile_pic
		json.writer_pic review.writer.profile_pic
	else
		json.writer_pic "http://linkhay2.vcmedia.vn/l/templates/images/no_thumb_120.png"
	end
	json.receiver review.receiver.name
	json.receiver_id review.receiver.id
	json.likers review.likes.take(3) do |like|
		json.name like.liker.name
		json.id like.liker.id
	end
	liked = review.likes.any? { |l| current_user.likes.any? { |ul| ul[:id] == l[:id]}}
	json.liked liked
	if liked
		json.users_like review.likes.where(liker: current_user).first
	end
	unless review.anonymous
		json.writer review.writer.name
		json.job review.job.title
	else 
		json.writer 'anonymous'
		json.job 'anonymous'
	end
	json.comment_count review.comments.count
	json.comments review.comments.order(created_at: :asc) do |comment|
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