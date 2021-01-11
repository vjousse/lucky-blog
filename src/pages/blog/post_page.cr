class Blog::PostPage < GuestLayout
  needs title : String
  needs html_content : String
  needs published_at : Time

  def page_title
    title
  end

  def content
    article class: "line-numbers flex flex-col justify-center tracking-tight text-justify leading-relaxed text-xl" do
      header class: "flex flex-col" do
        h1 title, class: "text-5xl font-serif font-bold pt-20 pb-16 text-center"

        div class: "text-gray-500 pb-6 italic text-center" do
          time "#{published_at.to_s("%d-%m-%Y")}", datetime: "#{published_at.to_s("%d-%m-%Y")}", class: "inline text-italic"

          raw "&nbsp;-&nbsp;"

          link "Vincent Jousse",
            to: Content::About, class: "block mt-4 lg:inline-block lg:mt-0 hover:text-red-900"
        end
      end

      raw html_content
    end
  end
end
