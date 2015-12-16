class ProjectForm
  include ActiveAttr::Model

  attribute :name
  validates_presence_of :name
  validates_length_of :description, maximum: 80, allow_blank: true

  attribute :url
  validates_presence_of :url
  validates_url :url, :allow_blank => true

  attribute :description
  validates_presence_of :description
  validates_length_of :description, maximum: 80, allow_blank: true

end
