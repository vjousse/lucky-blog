require "markd"
require "uri"
require "xml"

abstract class XMLAction < Lucky::Action
  accepted_formats [:xml], default: :xml

  def title
    "Vince's RSS Feed"
  end

  def description
    "Updates for Vince's"
  end

  def link
    "https://vincent.jousse.org/"
  end

  private def xml(articles : PostQuery)
    string = XML.build(indent: "  ", encoding: "UTF-8") do |xml|
      xml.element(
        "rss", 
        version: "2.0", 
        "xmlns:dc": "http://purl.org/dc/elements/1.1/",
        "xmlns:content": "http://purl.org/rss/1.0/modules/content/",
        "xmlns:atom": "http://www.w3.org/2005/Atom"
      ) do
        xml.element("channel") do
          xml.element("title") { xml.cdata title }
          xml.element("description") { xml.cdata description }
          xml.element("link") { xml.text URI.encode(link) }
          xml.element("generator") { xml.text "Lucky Framework" }
          xml.element("lastBuildDate") { xml.text Time.utc.to_rfc2822 }
          xml.element("atom:link") { 
            xml.attribute "href", URI.encode("#{link}#{request.path}")
            xml.attribute "rel", "self"
            xml.attribute "type", "application/rss+xml"
          }
          xml.element("ttl") { xml.text "60" }
          articles.each do |article|
            xml.element("item") do
              # title, description, link, category, dc:creator, pubDate, content:encoded
              xml.element("title") { xml.cdata article.title }
              if article.teaser
                xml.element("description") { xml.cdata article.teaser.not_nil! }
              end
              xml.element("link") { xml.text URI.encode("#{link}blog/#{article.slug}") }
              xml.element("dc:creator") { xml.cdata "Vincent Jousse" }
              xml.element("pubDate") { xml.text article.published_at.to_rfc2822 }
              if article.content
                content = Markd.to_html(article.content.not_nil!)
                xml.element("content:encoded") { xml.cdata content }
              end
            end
          end

        end
      end
    end
    Lucky::TextResponse.new(context, content_type: "application/rss+xml; charset=utf-8", body: string status: 200)
  end
end
