atom_feed do |feed|
  feed.title('Open Hunt - Most popular projects today')
  feed.updated(@feed_updated_at) if @projects.length > 0

  render @projects, feed: feed
end
