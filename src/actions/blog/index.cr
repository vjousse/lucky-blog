class Blog::Index < BrowserAction
  include Auth::AllowGuests

  Habitat.create do
    setting lang_to_display : String
  end

  get "/blog" do
    if settings.lang_to_display == "all"
      posts = PostQuery.new.published_at.desc_order
    else
      if settings.lang_to_display == "fr"
        lang_to_display = Post::Lang.new(:fr).value
      else
        lang_to_display = Post::Lang.new(:en).value
      end

      posts = PostQuery.new.lang(lang_to_display).published_at.desc_order
    end

    html Blog::IndexPage, posts: posts
  end
end

class Blog::IndexEn < BrowserAction
  include Auth::AllowGuests

  get "/en/blog" do
    posts = PostQuery.new.lang(Post::Lang.new(:en).value).published_at.desc_order

    html Blog::IndexPage, posts: posts
  end
end
