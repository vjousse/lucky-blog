class Blog::Index < BrowserAction
  include Auth::AllowGuests

  get "/blog" do

    posts = PostQuery.new.published_at.desc_order

    html Blog::IndexPage, posts: posts

  end
end
