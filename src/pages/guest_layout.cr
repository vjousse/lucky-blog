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
      mount Shared::LayoutHead, page_title: page_title, context: context

      body do

        nav class: "flex items-center justify-between flex-wrap p-6 lg:px-12 border-t-1 border-b-1 border-light-gray relative bg-gray-100 text-gray-900" do
          div class: "flex items-center flex-shrink-0 mr-6" do
            a class: "font-bold font-serif text-4xl tracking-tight", href: "/" do
              text "Vince's"
            end
          end
          div class: "w-full block lg:flex lg:items-end lg:w-auto" do
            ul class: "flex text-xl font-sans-serif align-text-bottom items-center" do
              li do
                link "Articles",
                  to: Blog::Index, class: "block mt-4 lg:inline-block lg:mt-0 hover:text-red-900"
              end
              li class: "ml-4 mr-4 text-gray-400" do
                text "|"
              end
              li do
                link "Research",
                  to: Content::Research, class: "block mt-4 lg:inline-block lg:mt-0 hover:text-red-900"
              end
              li class: "ml-4 mr-4 text-gray-400" do
                text "|"
              end
              li do

                link "?",
                  to: Content::About, class: "block mt-4 lg:inline-block lg:mt-0 hover:text-red-900 number-circle"
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
