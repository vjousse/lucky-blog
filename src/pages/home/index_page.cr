require "markd"

class Home::IndexPage < GuestLayout
  def content

    file_content = File.read("2013-01-23-le-courage-de-vivre-consciemment.md")
    html = Markd.to_html(file_content)


    article class: "flex flex-col justify-center tracking-tight text-justify" do


      header class: "flex flex-col" do

        h1 "Le courage de vivre consciemment", class: "text-5xl font-serif font-medium"

        div class: "flex text-gray-700 py-6 italic" do
          raw "Le&nbsp;"
          time "16 Mai", datetime: "2015-05-16 19:00", class: "inline text-italic"
          raw "&nbsp;par Vince"
        end

      end

      div class: "text-xl" do
        raw html
      end

    end
  end
end
