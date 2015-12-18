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

(0..10).each do |i|
  puts
  puts
  puts
  puts "creating projects for day #{i}"
  puts
  puts
  puts

  day = Time.find_zone!(Settings.base_timezone).now.beginning_of_day - i.days

  User.take(50).each do |user|
    created_time = day + rand(23).hours + rand(59).minutes + rand(59).seconds
    print "."
    $stdout.flush
    project = Project.new(
      name: Faker::Name.name,
      description: Faker::Hipster.sentences(1).first.truncate(80),
      url: Faker::Internet.url
    )
    project.user = user
    project.save!
    project.update_attributes(bucket: Project.bucket(created_time))
    user.vote(project)
    User.offset(rand(160)).take(rand(40)).each do |other_user|
      other_user.vote(project)
    end
  end
end

puts "DONE"
