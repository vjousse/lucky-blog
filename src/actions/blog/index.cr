class Blog::Index < BrowserAction
  include Auth::AllowGuests

  get "/blog" do

    posts = PostQuery.new.published_at.desc_order

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
