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
	
	json.subcategories @user.subcategories do |subcategory|
		if subcategory.category.id == category.id
			json.subcategory subcategory.sub
		end
	end
end

json.review_count @user.reviews.count
json.reviews @user.reviews.take(3) do |review|
	json.review review.review
	json.rating review.rating
	if not review.anonymous
		json.writer review.writer.name
		json.job review.job.title
	end
end

json.jobs_completed_count @user.jobs_completed

json.jobs_completed @user.jobs.completed do |j|
	json.title j.title
	json.id j.id
end

json.jobs_production_count @user.jobs.in_production.count
json.jobs_in_production @user.jobs.in_production do |j|
	json.title j.title
	json.time_left j.timeline
	json.id j.id
end

json.messages_unread @user.messages_in.unread.count
json.messages @user.messages_in.take(3) do |m|
	json.message truncate(m.message, :length => 65)
	json.created_at time_ago_in_words(m.created_at)
	json.sender m.sender.name
	json.sender_id m.sender.id
	json.status m.status
	json.id m.id
end

json.notifications_unread @user.notifications_in.unread.count
json.notifications @user.notifications_in.take(3) do |n|
	json.notification truncate(n.notification, :length => 65)
	json.created_at time_ago_in_words(n.created_at)
	json.initiator_id n.initiator.id
	json.initiator n.initiator.name
	json.status n.status
	json.id n.id
	json.event n.event
	json.category n.event.category.category
end

json.follower_request_unread @user.followers_requested.unread.count
json.follow_requests @user.followers_requested.take(4) do |f|
	json.request truncate(f.message, :length => 65)
	json.created_at time_ago_in_words(f.created_at)
	json.follower f.follower.name
	json.follower_id f.follower.id
	json.request_id f.id
	json.status f.status
end

