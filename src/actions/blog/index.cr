class Blog::Index < BrowserAction
  include Auth::AllowGuests

  Habitat.create do
    setting lang_to_display : String
  end

  get "/blog" do

    query = PostQuery.new

    if session_lang = session.get(:lang)
      query = query.lang(Post::Lang.new(session_lang).value)
    else
      if settings.lang_to_display != "all"
        query = query.lang(Post::Lang.new(settings.lang_to_display).value)
      end
    end

    posts = query.published_at.desc_order

    html Blog::IndexPage, posts: posts
  end
end

class Blog::IndexEn < BrowserAction
  include Auth::AllowGuests

  get "/blog/en" do
    posts = PostQuery.new.lang(Post::Lang.new(:en).value).published_at.desc_order

    html Blog::IndexPage, posts: posts
  end
end


class Blog::IndexFr < BrowserAction
  include Auth::AllowGuests

  get "/blog/fr" do
    posts = PostQuery.new.lang(Post::Lang.new(:fr).value).published_at.desc_order

    html Blog::IndexPage, posts: posts
  end
end
