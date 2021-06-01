require "noir"
require "noir/themes/monokai"
require "noir/lexers/crystal"
require "noir/lexers/css"
require "noir/lexers/html"
require "noir/lexers/javascript"
require "noir/lexers/json"
require "noir/lexers/python"
require "noir/lexers/ruby"

class MyHTMLRenderer < Cmark::HTMLRenderer
    def code(node)
      out %(<code class="inline-code">)
      out escape_html(node.literal)
      out "</code>"
    end

  def code_block(node)
    cr
    out %(<pre class="code")
    sourcepos node
    fence_info = node.fence_info

    if fence_info.bytesize.zero?
      out "><code>"
      out escape_html(node.literal),
    else
      tags = fence_info.split(' ', remove_empty: true)
      language_name = tags[0]

      if @options.github_pre_lang?
        out %( lang="#{escape_html(tags.shift)})
        tags.each { |tag| out %(" data-meta="#{escape_html(tag)}) } if @options.full_info_string?
        out %("><code class="highlight">)
      else
        out %(><code class="highlight language-#{escape_html(tags.shift)})
        tags.each { |tag| out %(" data-meta="#{escape_html(tag)}) } if @options.full_info_string?
        out %(">)
      end

      theme = Noir.find_theme("monokai").not_nil!


      formatter_out : IO = IO::Memory.new

      if lexer = Noir.find_lexer(language_name)

        Noir.highlight node.literal,
          lexer: lexer,
          formatter: Noir::Formatters::HTML.new formatter_out

        out formatter_out.to_s
      else
        pp "Lexer for #{language_name} not found"
        out escape_html(node.literal)
      end

    end


    out "</code></pre>\n"
  end

end

class Blog::PostDetail < BrowserAction
  include Auth::AllowGuests

  get "/blog/:lang/:post_slug" do
    post_slug_unescaped = URI.decode(post_slug)
    post = PostQuery.new.slug(post_slug_unescaped).first?

    if post

      options = Cmark::Option.flags(ValidateUTF8, Smart, Unsafe, GithubPreLang)
      extensions = Cmark::Extension.flags(Table, Tasklist) # default is Extension::None

      nodes = Cmark.parse_gfm(post.content.gsub("<p></p>", ""), options)

      renderer = MyHTMLRenderer.new(options, extensions)
      html_content = renderer.render(nodes)

      # html_content = Cmark.gfm_to_html(post.content.gsub("<p></p>", ""), options)

      html Blog::PostPage, title: post.title, html_content: html_content, published_at: post.published_at
    else
      raise Lucky::RouteNotFoundError.new(context)
    end
  end
end


class Blog::PostDetailLegacy < BrowserAction
  include Auth::AllowGuests

  get "/blog/:post_slug" do
    post_slug_unescaped = URI.decode(post_slug)
    post = PostQuery.new.slug(post_slug_unescaped).first?

    if post
      redirect to: Blog::PostDetail.with(post_slug: post.slug, lang: post.lang.to_s.downcase)
    else
      raise Lucky::RouteNotFoundError.new(context)
    end
  end
end
