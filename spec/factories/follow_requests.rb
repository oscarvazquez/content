FactoryGirl.define do
  factory :follow_request do
    follower nil
    followed nil
    message "MyString"
    status false
  end
end
