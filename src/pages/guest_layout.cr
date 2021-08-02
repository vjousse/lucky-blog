abstract class GuestLayout
  include Lucky::HTMLPage

  abstract def content
  abstract def page_title

  # GuestLayout defines a default 'page_title'.
  #
  # Add a 'page_title' method to your indivual pages to customize each page's
  # title.
  #
  # Or, if you want to require every page to set a title, change the
  # 'page_title' method in this layout to:
  #
  #    abstract def page_title : String
  #
  # This will force pages to define their own 'page_title' method.
  def page_title
    "Articles"
  end

  def render
    html_doctype

    html lang: "en" do
      mount Shared::LayoutHead, page_title: page_title

      body do
        nav class: "container flex items-center justify-between flex-wrap p-6 lg:px-64 relative text-gray-400 mx-auto" do
          div class: "flex items-center flex-shrink-0 mr-6" do
            a class: "font-bold font-serif text-3xl tracking-tight", href: "/" do
            end
          end
          div class: "w-full block lg:flex lg:items-end lg:w-auto" do
            ul class: "flex text-lg font-sans-serif align-text-bottom items-center" do
#              li class: "mt-1" do
#                link to: Blog::Index, class: "block mt-4 lg:inline-block lg:mt-0 hover:text-red-900" do

#                tag "svg", class: "h-6 w-6", fill: "none", stroke: "currentColor", viewBox: "0 0 24 24", xmlns: "http://www.w3.org/2000/svg" do
#                tag "path", d: "M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6", stroke_linecap: "round", stroke_linejoin: "round", stroke_width: "2"
#end
#                end
#              end
#              li class: "ml-4 mr-4 text-gray-400" do
#                text "|"
#              end
              li do
                link "Fr",
                  to: Blog::IndexFr, class: "block mt-4 lg:inline-block lg:mt-0 hover:text-red-900"
              end
              li class: "ml-4 mr-4 text-gray-400" do
                text "|"
              end
              li do
                link "En",
                  to: Blog::IndexEn, class: "block mt-4 lg:inline-block lg:mt-0 hover:text-red-900"
              end

              li class: "ml-4 mr-4 text-gray-400" do
                text "|"
              end
              li class: "mt-1" do
                link to: Content::About, title: "About", class: "block mt-4 lg:inline-block lg:mt-0 hover:text-red-900" do
                  tag "svg", class: "h-6 w-6", fill: "none", stroke: "currentColor", viewBox: "0 0 24 24", xmlns: "http://www.w3.org/2000/svg" do
                    tag "path", d: "M8.228 9c.549-1.165 2.03-2 3.772-2 2.21 0 4 1.343 4 3 0 1.4-1.278 2.575-3.006 2.907-.542.104-.994.54-.994 1.093m0 3h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z", stroke_linecap: "round", stroke_linejoin: "round", stroke_width: "2"
                  end
                end
              end
              li class: "ml-4 mr-4 text-gray-400" do
                text "|"
              end
              li class: "mt-1" do
                link to: Rss::Index, title: "RSS Feed", class: "block mt-4 lg:inline-block lg:mt-0 hover:text-red-900" do
                  tag "svg", class: "h-6 w-6", fill: "none", stroke: "currentColor", viewBox: "0 0 24 24", xmlns: "http://www.w3.org/2000/svg" do
                    tag "path", d: "M6 5c7.18 0 13 5.82 13 13M6 11a7 7 0 017 7m-6 0a1 1 0 11-2 0 1 1 0 012 0z", stroke_linecap: "round", stroke_linejoin: "round", stroke_width: "2"
                  end
                end
              end

            end
          end
        end
        # </nav>

        mount Shared::FlashMessages, context.flash

        main class: "container mx-auto px-10 lg:px-64" do
          content
        end

        footer class: "py-12" do
        end
      end
    end
  end
end
