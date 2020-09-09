class Blog::IndexPage < GuestLayout

  needs posts : Array(String)

  def content

    article class: "flex flex-col justify-center tracking-tight text-justify leading-relaxed" do

      if posts.size > 0
        ul class: "text-xl" do

          posts.each do |title|
            li title
          end

        end
      else
        h2 "No posts found"
      end

    end
  end
end
