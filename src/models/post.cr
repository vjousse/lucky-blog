require "noir"
require "noir/themes/monokai"
require "noir/lexers/crystal"
require "noir/lexers/css"
require "noir/lexers/html"
require "noir/lexers/javascript"
require "noir/lexers/json"
require "noir/lexers/python"
require "noir/lexers/ruby"

class PostHTMLRenderer < Cmark::HTMLRenderer
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
        Log.info { "Lexer for '#{language_name}' not found." }
        out escape_html(node.literal)
      end

    end


    out "</code></pre>\n"
  end

end


class Post < BaseModel

  avram_enum Lang do
    Fr # 0
    En # 1
  end

  table do
    column title : String
    column content : String
    column teaser : String?
    column slug : String
    column filename : String
    column published_at : Time
    column lang : Post::Lang
    column hash : String
  end

  def md_to_html(md : String): String
      options = Cmark::Option.flags(ValidateUTF8, Smart, Unsafe, GithubPreLang)
      extensions = Cmark::Extension.flags(Table, Tasklist)

      nodes = Cmark.parse_gfm(md.gsub("<p></p>", ""), options)

      renderer = PostHTMLRenderer.new(options, extensions)
      renderer.render(nodes)
  end

  def content_to_html : String
    md_to_html(self.content)
  end

  def teaser_to_html : String
    if teaser = self.teaser
      md_to_html(teaser)
    else
      ""
    end
  end

end
