class LoadPosts < LuckyCli::Task
  summary "Loads posts from markdown files"

  arg :lang, "Specify the lang of the posts to load",
      shortcut: "-l"


  arg :dir, "Specify the directory of the posts to load",
      shortcut: "-d"


  def help_message
    <<-TEXT
    #{summary}

    -l LANG,--lang=LANG             The language of the posts. It can be 'fr' or 'en'.
                                    Default to 'fr.
    -l DIRECTORY,--dir=DIRECTORY    The directory to read the posts from.

    example: lucky load_posts -l fr -d content/fr/
    TEXT
  end

  def call

    case lang
    when "en"
      posts_lang = Post::Lang.new(:en)
    else
      posts_lang = Post::Lang.new(:fr)
    end


    new_posts = {} of String => (Hash(String, String))
    old_posts = {} of String => Post

    query = PostQuery.new

    query.each do |post|
      old_posts[post.slug] = post
    end


    puts "#### Reading dir: #{dir} in #{lang}"

    Dir["#{dir}/*.md"].each do |filename|

      file_content = File.read(filename)
      hash = Digest::MD5.digest(file_content).to_slice.hexstring
      front_matter = Markdown::Parser.extract_front_matter(file_content)
      teaser = Markdown::Parser.extract_teaser(file_content)

      #next if front_matter["status"]? == "draft"
      if front_matter["status"]? == "draft"
        puts "- Skipping #{front_matter["slug"]} because it's draft"
        next
      end

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
              lang: posts_lang,
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
              lang: posts_lang,
              hash: hash,
              teaser: teaser,
              content: file_content)

            puts "-> Updating old post with slug #{slug}"
          end

      end

    end

  end
end
