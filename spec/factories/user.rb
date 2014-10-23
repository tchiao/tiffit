FactoryGirl.define do
  factory :user do
    name "Jennifer Lanre"
    sequence(:email, 100) { |n| "person#{n}@example.com" }
    password "password"
    password_confirmation "password"
    confirmed_at Time.now

    factory :user_with_post_and_comment do
      after(:build) do |user|
        post = create(:post, user: user)
        create(:comment, post: post, user: user)
      end
    end
  end
end