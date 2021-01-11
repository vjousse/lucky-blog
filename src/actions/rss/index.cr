class Rss::Index < ::XMLAction
  def title
    "Vince's Latest News"
  end

  get "/rss.xml" do
    articles = PostQuery.new.published_at.desc_order
    xml articles
  end
end
