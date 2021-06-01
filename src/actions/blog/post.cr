
class Blog::PostDetail < BrowserAction
  include Auth::AllowGuests

  get "/blog/:lang/:post_slug" do
    post_slug_unescaped = URI.decode(post_slug)
    post = PostQuery.new.slug(post_slug_unescaped).first?

    if post

      options = Cmark::Option.flags(ValidateUTF8, Smart, Unsafe)
      html_content = Cmark.gfm_to_html(post.content.gsub("<p></p>", ""), options)

      html Blog::PostPage, title: post.title, html_content: html_content, published_at: post.published_at
    else
      raise Lucky::RouteNotFoundError.new(context)
    end
  end
end


class Blog::PostDetailLegacy < BrowserAction
  include Auth::AllowGuests

  get "/blog/:post_slug" do
    post_slug_unescaped = URI.decode(post_slug)
    post = PostQuery.new.slug(post_slug_unescaped).first?

    if post
      redirect to: Blog::PostDetail.with(post_slug: post.slug, lang: post.lang.to_s.downcase)
    else
      raise Lucky::RouteNotFoundError.new(context)
    end
  end
end
