class Blog::IndexPage < GuestLayout
  needs posts : PostQuery

  def content
    div class: "flex flex-col justify-center tracking-tight text-justify leading-relaxed pt-20" do
      if posts.size > 0
        ul class: "text-xl" do
          posts.each do |post|
            li class: "list-none pb-20" do
              link to: Blog::PostDetail.with(post_slug: post.slug, lang: post.lang.to_s.downcase) do
                h2 post.title, class:"font-serif font-semibold"
              end

              div class: "text-gray-500 italic text-left text-sm" do
                time "#{post.published_at.to_s("%d-%m-%Y")}", datetime: "#{post.published_at.to_s("%d-%m-%Y")}", class: "inline text-italic"
                raw "&nbsp;-&nbsp;"

                link "Vincent Jousse",
                  to: Content::About, class: "block mt-4 lg:inline-block lg:mt-0 hover:text-red-900"
              end

              if teaser = post.teaser
                div do
                  raw post.teaser_to_html
                end

                div class: "text-right" do
                  link to: Blog::PostDetail.with(post_slug: post.slug, lang: post.lang.to_s.downcase) do
                    if post.lang.value === Post::Lang::Fr
                      text "Lire la suite >>"
                    else
                      text "Read more >>"
                    end
                  end
                end
              end
            end
          end
        end
      else
        h2 "No posts found"
      end
    end
  end
end
