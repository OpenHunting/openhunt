# before running, you could reset your db:
# rake db:drop db:create db:migrate db:seed

200.times do
  User.create(
    screen_name: Faker::Hipster.word,
    name: Faker::Name.name,
    profile_image_url: Faker::Avatar.image,
    twitter_id: Faker::Hipster.word,
    location: "#{Faker::Address.city}, #{Faker::Address.state}"
  )
end



User.take(25).each do |user|
  project = Project.new(
    name: Faker::Name.name,
    description: Faker::Hipster.sentences(1 + rand(2)),
    url: Faker::Internet.url
  )
  project.user = user
  project.created_at = DateTime.now - rand(24).hours
  project.save!
  user.vote(project)
  # TODO: random number of users vote on project
  User.offset(rand(160)).take(rand(40)).each do |other_user|
    other_user.vote(project)
  end
end
