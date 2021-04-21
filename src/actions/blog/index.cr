class Blog::Index < BrowserAction
  include Auth::AllowGuests

  Habitat.create do
    setting lang_to_display : String
  end

  get "/blog" do
    pp settings.lang_to_display
    if settings.lang_to_display == "all"
      posts = PostQuery.new.published_at.desc_order
    else
      if settings.lang_to_display == Post::Lang.new(:en).to_s.downcase
        lang_to_display = Post::Lang.new(:en).value
      elsif settings.lang_to_display == "session"
        # Get the value from the session set by the detect_lang mixin
        if lang = session.get?(:lang)
          Log.debug { "We should get the value from the session #{lang}" }
          lang_to_display = Post::Lang.new(lang).value
        else
          lang_to_display = Post::Lang.new(:fr).value
        end
      else
        lang_to_display = Post::Lang.new(:fr).value

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
