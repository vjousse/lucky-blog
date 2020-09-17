require "markd"

class Blog::IndexPage < GuestLayout

  needs posts : PostQuery

  def content

    div class: "flex flex-col justify-center tracking-tight text-justify leading-relaxed pt-10" do

      if posts.size > 0
        ul class: "text-xl" do

          posts.each do |post|
            li class: "list-none pb-10" do
              link to: Blog::PostDetail.with(post_slug: post.slug) do
                h2 post.title
              end

              div class: "text-gray-500 italic text-left text-sm" do
                raw "Le&nbsp;"
                time "#{post.published_at.to_s("%d-%m-%Y")}", datetime: "#{post.published_at.to_s("%d-%m-%Y")}", class: "inline text-italic"
                raw "&nbsp;par Vince"
              end

              if teaser = post.teaser
                html_teaser = Markd.to_html(teaser)

                div do
                  raw html_teaser
                end

                div class: "text-right italic" do
                  link to: Blog::PostDetail.with(post_slug: post.slug) do
                    text "Lire la suite >>"
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
