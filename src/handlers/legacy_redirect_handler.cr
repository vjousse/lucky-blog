class LegacyRedirectHandler
  include HTTP::Handler

  def call(context : HTTP::Server::Context)
    if context.request.path.starts_with?("/tech/")
      context.response.status_code = 301
      context.response.headers["Location"] = context.request.path.gsub("/tech", "/blog")
    elsif URI.decode(context.request.path).starts_with?("/à-propos")
      context.response.status_code = 301
      context.response.headers["Location"] = "/about"
    else
      call_next(context)
    end
  end
end
