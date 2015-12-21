class ProjectForm
  include ActiveAttr::Model

  attribute :name
  validates_presence_of :name
  validates_length_of :name, maximum: 80, allow_blank: true

  attribute :url
  validates_presence_of :url
  # validates_url :url, :allow_blank => true # do we need to ever allow a blank url?
  validate :check_unique_url

  attr_accessor :current_project_id

  def check_unique_url
    return if url.blank?

    normalized_url = Project.normalize_url(url)
    dupe_project = Project.get_duplicate_by_url(normalized_url)

    if dupe_project.present? and dupe_project.id != current_project_id
      errors.add(:url, "has already been submitted")
    end
  end

  attribute :description
  validates_presence_of :description
  validates_length_of :description, maximum: 80, allow_blank: true

  def self.for_update(params, project)
    params = params.with_indifferent_access
    form = ProjectForm.new
    form.current_project_id = project.id
    form.name = params[:name] || project.name
    form.url = params[:url] || project.url
    form.description = params[:description] || project.description
    form
  end
end
