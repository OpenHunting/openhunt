xml.item do
  xml.title project.name
  xml.description project.description
  xml.pubDate project.created_at.to_s(:rfc822)
  xml.link project.url
  xml.guid root_url(anchor: "open=#{project.slug}")
end
