require "markd"

class Home::IndexPage < GuestLayout
  def content

    file_content = File.read("2012-11-05-recrutement-développeur-web-comment-sortir-du-lot-cv-lettre-de-motivation.md")
    # file_content = File.read("2013-01-23-le-courage-de-vivre-consciemment.md")
    html = Markd.to_html(file_content.gsub("<p></p>", ""))


    article class: "flex flex-col justify-center tracking-tight text-justify leading-relaxed" do


      header class: "flex flex-col" do

        div class: "text-gray-500 py-6 italic text-right" do
          raw "Le&nbsp;"
          time "16 Mai", datetime: "2015-05-16 19:00", class: "inline text-italic"
          raw "&nbsp;par Vince"
        end

        h1 "Fin de la traduction de « The One Skill » de zenhabits", class: "text-5xl font-serif font-bold pt-20 pb-16"


      end

      div class: "text-xl" do
        raw html
      end

    end
  end
end
