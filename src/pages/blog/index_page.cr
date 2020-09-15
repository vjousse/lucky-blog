class Blog::IndexPage < GuestLayout

  needs posts : PostQuery

  def content

    article class: "flex flex-col justify-center tracking-tight text-justify leading-relaxed" do

      if posts.size > 0
        ul class: "text-xl" do

          posts.each do |post|
            li do
              link post.title,
                to: Blog::Post.with(post_slug: post.slug)
            end
          end

        end
      else
        h2 "No posts found"
      end

    end
  end
end
