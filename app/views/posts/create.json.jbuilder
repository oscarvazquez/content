json.id @post.id
json.writer @post.writer.name
json.writer_id @post.writer.id
json.post @post.post
json.created_at @post.created_at
json.like_count @post.likes.count
json.created_atn time_ago_in_words(@post.created_at)
if @post.writer.profile_pic
	json.writer_pic @post.writer.profile_pic
else
	json.writer_pic "http://linkhay2.vcmedia.vn/l/templates/images/no_thumb_120.png"
end
json.images @post.images do |c|
	json.image_url c.url
end
liked = @post.likes.any? { |l| current_user.likes.any? { |ul| ul[:id] == l[:id]}}
json.liked liked
	json.comment_count @post.comments.count
json.comments @post.comments.order(created_at: :asc) do |comment|
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