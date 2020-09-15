require "uri"
require "markd"

class Blog::Post < BrowserAction
  include Auth::AllowGuests

  get "/blog/:post_slug" do

    post_slug_unescaped = URI.decode(post_slug)
    post = PostQuery.new.slug(post_slug_unescaped).first?

    if post
      html_content = Markd.to_html(post.content.gsub("<p></p>", ""))

      html Blog::PostPage, title: post.title, html_content: html_content
    else
      raise Lucky::RouteNotFoundError.new(context)
    end
  end
end
