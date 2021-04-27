class Blog::Index < BrowserAction
  include Auth::AllowGuests

  Habitat.create do
    setting lang_to_display : String
  end

  get "/blog" do
    #redirect Home::Index

    posts = PostQuery.new.lang(Post::Lang.new(:en).value).published_at.desc_order

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
