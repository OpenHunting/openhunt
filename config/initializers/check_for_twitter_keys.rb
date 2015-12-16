# Warn user if theres no twitter_key or twitter_secret configured
if Settings.twitter_key.blank? or Settings.twitter_secret.blank?
  puts "MISSING: `Settings.twitter_key` and/or `Settings.twitter_secret`"
  if Rails.env.production?
    puts("SET IT WITH: ENV['Settings.twitter_key'] and ENV['Settings.twitter_secret']")
  else
    puts("ADD A FILE: config/settings.local.yml (see config/settings.local.yml.example)")
  end
end
