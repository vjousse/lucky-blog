class Markdown::Parser
  def self.extract_front_matter(content : String) : Hash(String, String)
    front_matters = {} of String => String

    if content.starts_with?("<!--")
      content.each_line do |line|
        if line.starts_with?("-->")
          # End of front matter
          break
        end

        sc_index = line.index(":")

        if sc_index
          content_array = line.split(":")

          # Parse ".. title: blah"
          key = line[0...sc_index].gsub(/\.\. /, "").strip
          value = line[(sc_index + 1)..-1].strip

          front_matters[key] = value
        end
      end
    end

    front_matters
  end

  def self.extract_teaser(content : String) : (String | Nil)
    front_matter_index = content.index("-->")
    teaser_index = content.index("<!-- TEASER_END -->")

    if teaser_index
      start = 0
      if front_matter_index && (front_matter_index + 3 < content.size)
        start = front_matter_index + 3
      end

      return content[start..teaser_index - 1].strip
    end
  end
end
