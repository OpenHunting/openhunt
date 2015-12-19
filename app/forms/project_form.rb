class ProjectForm
  include ActiveAttr::Model

  attribute :name
  validates_presence_of :name
  validates_length_of :name, maximum: 80, allow_blank: true

  attribute :url
  validates_presence_of :url
  # validates_url :url, :allow_blank => true # do we need to ever allow a blank url?
  attr_accessor :skip_url_validation
  validate :check_unique_url, unless: :skip_url_validation
  def check_unique_url
    return if url.blank?

    normalized_url = Project.normalize_url(url)

    # TODO: also add a date range, so projects can be resubmitted after X weeks
    if ( Project.where(normalized_url: normalized_url).count > 0 || Project.duplicate_exists?(url) )
        errors.add(:url, "has already been submitted")
    end
  end

  attribute :description
  validates_presence_of :description
  validates_length_of :description, maximum: 80, allow_blank: true

  def self.for_update(params, project)
    params = params.with_indifferent_access
    form = ProjectForm.new(skip_url_validation: should_skip_url_validation?(params[:url], project.url))
    form.name = params[:name] || project.name
    form.url = params[:url] || project.url
    form.description = params[:description] || project.description
    form
  end

  def self.should_skip_url_validation?(params_url, project_url)
    return true if params_url_is_very_similar?(params_url, project_url)
    return true if params_url.blank?
    return false
  end

  def self.params_url_is_very_similar?(params_url, project_url)
    existing_normalized_url = Project.normalize_url(project_url)
    existing_normalized_url = Project.slice_www(existing_normalized_url)
    params_normalized_url = Project.normalize_url(params_url)
    params_normalized_url = Project.slice_www(params_normalized_url)

    return true if existing_normalized_url == params_normalized_url
    return false
  end

end
