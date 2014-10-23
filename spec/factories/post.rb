FactoryGirl.define do
  factory :post do
    title "Post Title"
    body "Here is the body of my post. It is fascinating."
    user
    topic { Topic.create(name: 'Topic Title') }
  end
end