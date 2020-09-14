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

      if front_matter["slug"]?
          slug = front_matter["slug"]

          new_posts[slug] = front_matter

          old_post = old_posts[slug]?

          # Load only new posts
          if !old_post

            puts "-> Creating new post with slug #{slug}"

            SavePost.create!(
              title: front_matter["title"],
              slug: slug,
              filename: filename,
              #TODO use an enum
              lang: 1,
              #TODO use time from file
              published_at: Time.utc,
              hash: hash,
              content: file_content)

          elsif old_post.hash != hash
            SavePost.update!(old_post,
              title: front_matter["title"],
              slug: slug,
              filename: filename,
              #TODO use an enum
              lang: 1,
              hash: hash,
              content: file_content)

            puts "-> Updating old post with slug #{slug}"
          end

      end

    end

    #pp new_posts

  end
end
