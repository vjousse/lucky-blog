require "uri"
require "markd"

class Blog::Post < BrowserAction
  include Auth::AllowGuests

  get "/blog/:post_slug" do

    post_slug_unescaped = URI.decode(post_slug)

    file_content = File.read("content/fr/#{post_slug_unescaped}.md")

    front_matter = Markdown::Parser.extract_front_matter(file_content)

    title = ""
    if front_matter
      title = front_matter["title"]
    end

    html_content = Markd.to_html(file_content.gsub("<p></p>", ""))

    html Blog::PostPage, title: title, html_content: html_content
  end
end
