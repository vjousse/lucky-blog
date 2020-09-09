class Blog::Index < BrowserAction
  include Auth::AllowGuests

  get "/blog" do

    posts = [] of String

    Dir["content/fr/*.md"].each do |filename|

      puts "Got #{filename}"

      file_content = File.read(filename)
      front_matter = Markdown::Parser.extract_front_matter(file_content)

      if front_matter && front_matter.has_key?("title")
          posts << front_matter["title"]
      end

    end

    html Blog::IndexPage, posts: posts

  end
end
