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
    "Welcome"
  end

  def render
    html_doctype

    html lang: "en" do
      mount Shared::LayoutHead.new(page_title: page_title, context: context)

      body do

        nav class: "flex items-center justify-between flex-wrap p-6 lg:px-12 border-t-1 border-b-1 border-light-gray relative bg-very-light-gray text-gray-900" do
          div class: "flex items-center flex-shrink-0 mr-6" do
            a class: "font-bold font-serif text-4xl tracking-tight", href: "#" do
              text "The learning blog"
            end
          end
          div class: "w-full block lg:flex lg:items-end lg:w-auto" do
            ul class: "flex text-xl font-sans-serif align-text-bottom" do
              li do
                a class: "block mt-4 lg:inline-block lg:mt-0 hover:text-red-900", href: "#responsive-header" do
                  text "Blog"
                end
              end
              li class: "ml-4 mr-4 text-gray-400" do
                text "|"
              end
              li do
                a class: "block mt-4 lg:inline-block lg:mt-0 hover:text-red-900", href: "#responsive-header" do
                  text " Tech"
                end
              end
              li class: "ml-4 mr-4 text-gray-400" do
                text "|"
              end
              li do
                a class: "block mt-4 lg:inline-block lg:mt-0 hover:text-red-900", href: "#responsive-header" do
                  text " À propos"
                end
              end
            end
          end
        end

        mount Shared::FlashMessages.new(context.flash)
        content
      end
    end
  end

end
