class LegacyRedirectHandler
  include HTTP::Handler

  def call(context : HTTP::Server::Context)


    if md = /\/en(.*)/.match(context.request.path)
      Log.info { {match_data: md} }

      if new_path = md[1]?
        Log.info { {new_path: new_path} }
        if new_path == ""
          new_path = "/"
        end

        context.response.status_code = 301
        context.response.headers["Location"] = new_path

      end
    elsif context.request.path.starts_with?("/tech/")
      context.response.status_code = 301
      context.response.headers["Location"] = context.request.path.gsub("/tech", "/blog")
    else
      call_next(context)
    end

  end
end
