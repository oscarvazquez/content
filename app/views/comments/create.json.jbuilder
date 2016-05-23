json.id @comment.id
json.comment @comment.comment
json.commenter @comment.commenter.name
json.commenter_id @comment.commenter.id
json.commenter_type @comment.commenter_type
json.created_at @comment.created_at
json.created_atn time_ago_in_words(@comment.created_at)
json.like_count @comment.likes.count
json.likers @comment.likes.take(3) do |like|
	json.name like.liker.name
	json.id like.liker.id
end
json.can_delete true
json.liked false
json.images @comment.images do |c|
	json.image_url c.url
end
if @comment.commenter.profile_pic
	json.commenter_pic @comment.commenter.profile_pic
else
	json.commenter_pic "http://linkhay2.vcmedia.vn/l/templates/images/no_thumb_120.png"
end	