feed.entry(project, url: project.url) do |entry|
  entry.title(project.name)
  entry.content(project.description)

  entry.author do |author|
    author.name(project.user.screen_name)
  end
end
