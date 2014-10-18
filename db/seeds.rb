require 'faker'

# Create admin
admin = User.new(
  name: 'Admin User',
  email: 'admin@tiffit.com',
  password: 'helloworld',
  role: 'admin'
)
admin.skip_confirmation!
admin.save!

# Create moderator
moderator = User.new(
  name: 'Moderator User',
  email: 'mod@tiffit.com',
  password: 'helloworld',
  role: 'moderator'
)
moderator.skip_confirmation!
moderator.save!

# Create member
member = User.new(
  name: 'Member User',
  email: 'member@tiffit.com',
  password: 'helloworld'
)
member.skip_confirmation!
member.save!

# Create more users
5.times do
  user = User.new(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    password: Faker::Lorem.characters(10)
  )
  user.skip_confirmation!
  user.save!
end
users = User.all

topic_array = ["Astounding Adventures", "Baleful Books", "Calamitous Conspiracies", "Delirious Daydreams", "Exuberant Events", "Fantastical Fairytales", "Glowing Gems", "Historical Heroes", "Invigorating Intrigues", "Jocular Jokes", "Key Knowledge", "Long-Standing Lore", "Meritorious Morals", "Newfangled Novels", "Opulent Overtones", "Pretentious Plays", "Quixotic Quotes", "Resplendent Recipes", "Sensible Subjects", "Thrilling Tales", "Unheard-of Utopias", "Venerable Voyages", "Wondrous Wanderers", "Xeric Xenoliths", "Yesteryear Youths", "Zealous Zephyrs"]
# Create topics
topic_array.each do |title|
  topic = Topic.create!(
    name: title,
    description: Faker::Lorem.paragraph
  )
end
topics = Topic.all

# Create posts
75.times do
  post = Post.create!(
    user: users.sample,
    topic: topics.sample,
    title: Faker::Lorem.sentence,
    body:  Faker::Lorem.paragraph
  )
  post.update_attributes!(created_at: rand(10.minutes .. 1.year).ago)
  post.create_vote
  post.update_rank
end
posts = Post.all

# Create comments
150.times do
  Comment.create!(
    user: users.sample,
    post: posts.sample,
    body: Faker::Lorem.paragraph
  )
end

puts "Seed finished"
puts "#{User.count} users created"
puts "#{Topic.count} topics created"
puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"