class ProjectForm
  include ActiveAttr::Model

  attribute :name
  validates_presence_of :name
  # TODO: validate it isnt too long

  attribute :url
  validates_presence_of :url
  # validate it's a real url

  attribute :description
  validates_presence_of :description
  # TODO: validate it isnt too long
end
