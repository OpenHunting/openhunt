# group :specs do
#   guard :rspec, cmd: 'bundle exec rspec' do
#     watch('spec/spec_helper.rb')                        { "spec" }
#     watch('config/routes.rb')                           { "spec/routing" }
#     watch('app/controllers/application_controller.rb')  { "spec/controllers" }
#     watch(%r{^spec/.+_spec\.rb$})
#     watch(%r{^app/(.+)\.rb$})                           { |m| "spec/#{m[1]}_spec.rb" }
#     watch(%r{^app/(.*)(\.erb|\.haml|\.slim)$})          { |m| "spec/#{m[1]}#{m[2]}_spec.rb" }
#     watch(%r{^lib/(.+)\.rb$})                           { |m| "spec/lib/#{m[1]}_spec.rb" }
#     watch(%r{^app/controllers/(.+)_(controller)\.rb$})  { |m| ["spec/routing/#{m[1]}_routing_spec.rb", "spec/#{m[2]}s/#{m[1]}_#{m[2]}_spec.rb", "spec/acceptance/#{m[1]}_spec.rb"] }
#   end
# end


# Reload the browser as asset files change
# install the Chrome plugin here: http://bit.ly/UNR8rC
guard :livereload, :apply_js_live => false do
  watch(%r{^app/.+\.(erb|haml|slim)$})

  watch(%r{^app/helpers/.+\.rb$})
  watch(%r{^(public/|app/assets).+\.(css|js|html)$})
  watch(%r{^(app/assets/.+\.css)\.s[ac]ss$}) { |m| m[1] }
  watch(%r{^(app/assets/.+\.js)\.coffee$}) { |m| m[1] }

  watch(%r{^(app-css/.+\.css)\.s[ac]ss$}) { |m| m[1] }

  watch(%r{^(app-js/.+)\.hbs$}) { |m| m[1] }
  watch(%r{^(app-js/.+)\.emblem$}) { |m| m[1] }
end
