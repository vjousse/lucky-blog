require "./server"

Lucky::Session.configure do |settings|
  settings.key = "_my_app_session"
end

Lucky::CookieJar.configure do |settings|
  settings.on_set = ->(cookie : HTTP::Cookie) {
    # If ForceSSLHandler is enabled, only send cookies over HTTPS
    cookie.secure(Lucky::ForceSSLHandler.settings.enabled)

    # By default, don't allow reading cookies with JavaScript
    cookie.http_only(true)

    # You can set other defaults for cookies here. For example:
    #
    #    cookie.expires(1.year.from_now).domain("mydomain.com")

    # Add this line. See ref: https://github.com/crystal-lang/crystal/pull/10491
    cookie.path("/")
  }
end
