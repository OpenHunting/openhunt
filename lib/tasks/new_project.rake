namespace :new_project do
  def file_string_replace(file_path, old_string, new_string)
    text = File.read(file_path)
    File.open(file_path, "w") {|file| file.puts text.gsub(old_string, new_string) }
  end

  desc "Renames Rails app name to the Camel Cased name of the folder"
  task :rename => :environment do
    project_name =  File.basename(Rails.root)

    camelized = project_name.camelize

    # replace references in application.rb and session_store
    file_string_replace(Rails.root.join("config", "application.rb").to_s, "NewProject", camelized)
    file_string_replace(Rails.root.join("config", "initializers", "session_store.rb").to_s, "new_project", project_name)

    # replace layout title
    file_string_replace(Rails.root.join("app", "views", "layouts", "application.html.erb").to_s, "NewProject", camelized.underscore.titleize)
  end
end
