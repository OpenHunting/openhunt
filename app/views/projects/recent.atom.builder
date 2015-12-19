atom_feed do |feed|
  feed.title('Open Hunt - Recently added projects')
  feed.updated(@projects[0].created_at) if @projects.length > 0

  render @projects, feed: feed
end
