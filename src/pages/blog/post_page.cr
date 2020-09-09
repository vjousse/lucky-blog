class Blog::PostPage < GuestLayout

  needs title : String
  needs html_content : String

  def content

    article class: "flex flex-col justify-center tracking-tight text-justify leading-relaxed" do


      header class: "flex flex-col" do

        div class: "text-gray-500 py-6 italic text-right" do
          raw "Le&nbsp;"
          time "16 Mai", datetime: "2015-05-16 19:00", class: "inline text-italic"
          raw "&nbsp;par Vince"
        end

        h1 title, class: "text-5xl font-serif font-bold pt-20 pb-16 text-center"


      end

      div class: "text-xl" do
        raw html_content
      end

    end
  end
end

