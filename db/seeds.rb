categories = Category.create([{category: 'Medical'}, {category: "Law"}, {category: "Finance"}, {category: "Education"}])

subcategories = Subcategory.create([{sub: "Pediatrics", category: Category.first}, {sub: "Gynecology", category: Category.first}, {sub: "Dentistry", category: Category.first}, {sub: "Securities", category: Category.second}, {sub: "Criminal Justice", category: Category.second}, {sub: "Real Estate Law", category: Category.second}, {sub: "Commodities", category: Category.third}, {sub: "Municipal Bonds", category: Category.third}])

user1 = User.create(first_name: 'Oscar', last_name: "Vazquez", email: 'oscar.vazquez2012@gmail.com', password: "redfred", password_confirmation: 'redfred', excerpt: "I am an awesome writer I am just the type of guy you are looking for", summary: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.")
puts user1.errors.full_messages
user1.set_category!(Category.second)
user1.set_category!(Category.fourth)
user1.set_category!(Category.third)

user1.set_subcategory!(Subcategory.fourth)
user1.set_subcategory!(Subcategory.fifth)
user1.set_subcategory!(Subcategory.find(7))
user1.set_subcategory!(Subcategory.find(8))
user1.update_attribute(:confirmation_email, true)

user2 = User.create(first_name: 'Gustavo', last_name: "Vazquez", email: 'gustavo.vazquez2012@gmail.com', password: "redfred", password_confirmation: 'redfred', excerpt: "I am an alright writer I am just the type of guy you are looking for", summary: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.")
user2.set_category!(Category.first)
user2.set_subcategory!(Subcategory.first)
user2.set_subcategory!(Subcategory.second)
user2.update_attribute(:confirmation_email, true)


biz1 = Business.create(name: 'Instituto Mujeres', email: 'institut@gmail.com', password: 'redfred', street_address: 'pacific place 1807', zip_code: "00911", city: 'san juan', country: 'PR', state: "PR")
biz2 = Business.create(name: 'Coding Dojo', email: 'codingdojo@gmail.com', password: 'redfred', street_address: '1980 zanker road', zip_code: "95112", city: 'San Jose', country: 'US', state: "California")
biz3 = Business.create(name: 'Apple', email: 'apple@gmail.com', password: 'redfred', street_address: ' N Tantau Ave, Cupertino, CA 95014', zip_code: "10955", city: 'Cupertino', country: 'US', state: "California")

biz1.set_category!(Category.first)
biz1.set_subcategory!(Subcategory.first)
biz2.set_category!(Category.second)
biz2.set_subcategory!(Subcategory.fourth)
biz3.set_category!(Category.second)
biz3.set_subcategory!(Subcategory.fourth)
biz1.set_subcategory!(Subcategory.second)
puts biz1.errors.full_messages

Job.create(length: 1000, price: 200, timeline: '5m', business: Business.first, user: User.first, title: 'Awesome Article', category: Category.first)
Job.create(length: 1000, price: 200, timeline: '5m', business: Business.first, user: User.first, title: 'Securities Law Article', category: Category.first)
Job.create(length: 1000, price: 200, timeline: '5m', business: Business.first, user: User.first, title: 'Home Owners Law Article', category: Category.first)
Job.create(length: 1000, price: 200, timeline: '5m', business: Business.first, user: User.first, title: 'Medical Law Article', category: Category.first)

# im going to have to change these at one point reviews are going to be given only per job
# so a user wont be able to give unlimited reviews, they will be able to give a review per job
review1 = Review.create(review: 'I think this guy did an amazing job, he was very professional and was able to meet our timeline. I reccomend this writer to all of our associates', rating: 5, writer: Business.first, receiver: User.first, job: Job.first)
review2 = Review.create(review: 'this guy was awesome', rating: 3, writer: Business.first, receiver: User.first, job: Job.second)
review3 = Review.create(review: "this guy kind of sucked, it's like he wasn't even trying. He ended up turning our content like 3 weeks late, and it was poorly written. However, blah blah blah blah blah blah blah blah blah blah blah blah", rating: 2, writer: Business.second, receiver: User.first, job: Job.third)
review4 = Review.create(review: 'this guy was awesome', rating: 3, writer: Business.first, receiver: User.first, job: Job.fourth)
review6 = Review.create(review: 'this biz was awesome', rating: 1, writer: User.first, receiver: Business.first, job: Job.fourth)
review7 = Review.create(review: 'this biz was awesome', rating: 5, writer: User.first, receiver: Business.first, job: Job.third)
puts review1.errors.full_messages

commentReview1 = Comment.create(commentable: Review.first, commenter: User.first, comment: "Thanks for the insight Ill keep trying my hardest to produce quality content")
commentReview2 = Comment.create(commentable: Review.first, commenter: Business.first, comment: "No problem I hope that you keep it up!")
commentReview3 = Comment.create(commentable: Review.second, commenter: User.first, comment: "Thanks for the insight Ill keep trying my hardest to produce quality content")
commentReview4 = Comment.create(commentable: Review.third, commenter: User.first, comment: "Well that was a little uncalled for.. blah blah blah... blah")
commentReview5 = Comment.create(commentable: Review.third, commenter: Business.second, comment: "Probably... blah")

likeC1 = Like.create(likeable: Comment.first, liker: Business.first)
likeC2 = Like.create(likeable: Comment.first, liker: User.first)
likeC3 = Like.create(likeable: Comment.first, liker: Business.second)
likeC4 = Like.create(likeable: Comment.second, liker: User.second)
likeC5 = Like.create(likeable: Review.third, liker: User.second)

likeR1 = Like.create(likeable: Review.first, liker: User.first)
likeR2 = Like.create(likeable: Review.first, liker: Business.first)


puts 'this should be 3.25'
puts User.first.show_rating
puts 'this should be 3'
puts Business.first.show_rating


Pitch.create(title: 'this is a title and its awesome', pitch: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an aosidnf aoisdnf aisdf id  sid ausd oasis soid s9e aakls alskd slie and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.", length: 1000, price: 200, timeline: '5m', business: Business.first, user: User.first)
Pitch.create(title: 'this is a title and its awesome', pitch: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an aosidnf aoisdnf aisdf id  sid ausd oasis soid s9e aakls alskd slie and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.", length: 1000, price: 200, timeline: '5m', business: Business.first, user: User.second)
Pitch.create(title: 'this is a title and its awesome', pitch: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an aosidnf aoisdnf aisdf id  sid ausd oasis soid s9e aakls alskd slie and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.", length: 1000, price: 200, timeline: '5m', business: Business.first, user: User.second)
Pitch.create(title: 'this is a title and its awesome', pitch: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an aosidnf aoisdnf aisdf id  sid ausd oasis soid s9e aakls alskd slie and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.", length: 1000, price: 200, timeline: '5m', business: Business.first, user: User.first)
Pitch.create(title: 'this is a title and its awesome', pitch: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an aosidnf aoisdnf aisdf id  sid ausd oasis soid s9e aakls alskd slie and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.", length: 1000, price: 200, timeline: '5m', business: Business.first, user: User.first)
Pitch.create(title: 'this is a title and its awesome', pitch: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an aosidnf aoisdnf aisdf id  sid ausd oasis soid s9e aakls alskd slie and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.", length: 1000, price: 200, timeline: '5m', business: Business.first, user: User.second)
Pitch.create(title: 'this is a title and its awesome', pitch: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an aosidnf aoisdnf aisdf id  sid ausd oasis soid s9e aakls alskd slie and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.", length: 1000, price: 200, timeline: '5m', business: Business.first, user: User.first)

@social = Hash.new
@social['facebook'] = "facebook.com/oscar"
@social['twitter'] = "twitter.com/oscar"
@social['linked_in'] = "linkedin.com/oscar"
@social['website'] = "oscar.tech"
user1.update_attributes(@social)
@user2 = User.find(user1.id)
puts user1.id

FollowRequest.create(follower: Business.first, followed: User.first, message: 'please let me follow you')
FollowRequest.create(follower: Business.second, followed: User.first, message: 'please let me follow you')
FollowRequest.create(follower: Business.third, followed: User.first, message: 'please let me follow you Ill do anything!!!')

Follower.create(follower: User.first, followed: Business.first)


2.times do |i|
	Message.create(sender: Business.first, receiver: User.first, message: 'hey bro I like what you do, write some stuff up for me')
end
2.times do |i|
	Message.create(sender: User.first, receiver: Business.first, message: 'hey bro I like what you do, write some stuff up for me')
end

2.times do |n|
	Request.create(business: Business.first, category: Category.second, description: "I want an awesome article that will be the best article ever", length: 1000, title: 'I need an awesome article atleast 1000')
end
Request.create(business: Business.first, category: Category.second, description: "This article needs to be even cooler than the other one", length: 1000, title: 'I need an awesome article atleast 1000')



Post.create(writer: User.first, post: 'I cant believe that we have finally made it to the point in our society where blah blah blah,', subcategory: Subcategory.fourth)
Post.create(writer: User.first, post: 'I am stating a bunch of stuff that doesnt make much sense and Im doing it to show that I care about stuff about I actually dont really care about where blah blah blah,', subcategory: Subcategory.fifth)
Post.create(writer: User.first, post: 'I cant believe that we have finally made it to the point in our society where blah blah blah,', subcategory: Subcategory.fourth)

