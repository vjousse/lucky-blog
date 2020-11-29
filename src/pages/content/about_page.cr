class Content::AboutPage < GuestLayout

  def page_title
    "About"
  end

  def content

    article class: "flex flex-col justify-center tracking-tight text-justify leading-relaxed text-xl" do

      h2 "License"
      para do
        text "All the content of this site is released under the "
        a href: "https://creativecommons.org/licenses/by/4.0/", target: "_blank" do
          strong "CC-By Licence"
        end
        text "."
      end
      h2 "Me"
      para do
        text "My name is "
        a href: "http://twitter.com/vjousse" do
          strong "Vincent Jousse"
        end
        text ", you can find me on "
        a "Twitter", href: "http://twitter.com/vjousse"
        text ", "
        a "Mastodon", href: "https://mamot.fr/@vjousse", rel: "me"
        text " or "
        a "Linkedin", href: "https://www.linkedin.com/in/vincent-jousse-798b1a11/", rel: "me"
        text "."
      end
      ul class: "list-none" do
        li do
          text "✓ I'm the "
          strong do
            text "CTO of "
            a "Allo-media", href: "https://allo-media.fr"
          end
          text "."
        end
        li do
          text "✓ I'm "
          strong "coding using Python, Rust, Crystal and Elm"
          text " on "
          a "github", href: "https://github.com/vjousse/"
        end
        li do
          text "✓ I wrote "
          strong "a PhD Thesis"
          text " about "
          link "named speaker identification", to: Content::Research 
        end
        li do
          text "✓ I was "
          strong "teaching computer science"
          text " at the "
          a "University of Le Mans", href: "http://www.univ-lemans.fr/en/index.html"
        end
        li do
          text "✓ I wrote a "
          a "book about Vim", href: "https://vimebook.com"
          text " called \""
          strong "Vim for humans"
          text "\" (free price)"
        end
      end
    end

  end
end
