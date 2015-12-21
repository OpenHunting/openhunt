# Be sure to restart your server when you modify this file.

Rails.application.config.session_store :cookie_store, {
  key: '_openhunt_session',
  expire_after: 60.days,
}
