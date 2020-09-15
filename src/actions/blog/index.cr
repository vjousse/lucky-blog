class Blog::Index < BrowserAction
  include Auth::AllowGuests

  get "/blog" do

    posts = PostQuery.new

    html Blog::IndexPage, posts: posts

  end
end
