class LoadPosts < LuckyCli::Task
  summary "Loads posts from markdown files"

  def call

    new_posts = {} of String => (Hash(String, String))
    old_posts = {} of String => Post

    query = PostQuery.new

    query.each do |post|
      old_posts[post.slug] = post
    end


    puts "####################"

    Dir["content/fr/*.md"].each do |filename|

      puts "Got #{filename}"

      file_content = File.read(filename)
      hash = Digest::MD5.digest(file_content).to_slice.hexstring
      front_matter = Markdown::Parser.extract_front_matter(file_content)
      teaser = Markdown::Parser.extract_teaser(file_content)

      if front_matter["slug"]?
          slug = front_matter["slug"]
          date = front_matter["date"]?

          if date
            date = Time.parse!(date, "%Y-%m-%d %H:%M:%S%:z")
          else
            date = Time.utc
          end

          new_posts[slug] = front_matter

          old_post = old_posts[slug]?

          # Load only new posts
          if !old_post

            puts "-> Creating new post with slug #{slug}"

            SavePost.create!(
              title: front_matter["title"],
              slug: slug,
              filename: filename,
              lang: Post::Lang.new(:fr),
              published_at: date,
              hash: hash,
              teaser: teaser,
              content: file_content)

          elsif old_post.hash != hash
            SavePost.update!(old_post,
              title: front_matter["title"],
              slug: slug,
              filename: filename,
              published_at: date,
              lang: Post::Lang.new(:fr),
              hash: hash,
              teaser: teaser,
              content: file_content)

            puts "-> Updating old post with slug #{slug}"
          end

      end

    end

  end
end
