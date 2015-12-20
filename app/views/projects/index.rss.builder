xml.instruct! :xml, version: "1.0"
xml.rss version: "2.0" do
  xml.channel do
    xml.title 'Open Hunt - Most popular projects today'
    xml.description 'Discover new products, give feedback, help each other'
    xml.link root_url

    render @projects, xml: xml
  end
end
