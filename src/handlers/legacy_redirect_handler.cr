class LegacyRedirectHandler
  include HTTP::Handler

  def call(context : HTTP::Server::Context)
    if md = /\/en(.*)/.match(context.request.path)
      if new_path = md[1]?
        if new_path == ""
          new_path = "/"
        end

        context.response.status_code = 301
        context.response.headers["Location"] = new_path
      end
    elsif context.request.path.starts_with?("/tech/")
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
