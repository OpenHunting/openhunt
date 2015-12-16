class ProjectForm
  include ActiveAttr::Model

  attribute :name
  validates_presence_of :name

  attribute :url
  validates_presence_of :url
  validates_url :url, :allow_blank => true
  validate :check_unique_url
  def check_unique_url
    return if url.blank?

    normalized_url = Project.normalize_url(url)

    if Project.where(normalized_url: normalized_url).count > 0
      errors.add(:url, "has already been submitted")
    end
  end

  attribute :description
  validates_presence_of :description
  validates_length_of :description, maximum: 80, allow_blank: true



end
