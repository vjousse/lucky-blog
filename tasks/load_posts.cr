class Blog::LoadPosts < LuckyCli::Task
  summary "Loads posts from markdown files"

  def call

    new_posts = {} of String => (Hash(String, String))

    Dir["content/fr/*.md"].each do |filename|

      puts "Got #{filename}"

      file_content = File.read(filename)
      front_matter = Markdown::Parser.extract_front_matter(file_content)

      if front_matter && front_matter.has_key?("slug")
          new_posts[front_matter["slug"]] = front_matter

          SavePost.create!(
            title: front_matter["title"],
            slug: front_matter["slug"],
            filename: filename,
            #TODO use an enum
            lang: 1,
            #TODO use time from file
            published_at: Time.utc,
            content: file_content)

      end

    end

    pp new_posts

  end
end
