FactoryGirl.define do
  factory :notification do
    receiver ""
    event nil
    initiator nil
    notification "MyString"
  end
end
