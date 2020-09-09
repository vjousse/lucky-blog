class Markdown::Parser
  def self.extract_front_matter(content : String)

    if content.starts_with?("<!--")
        pp "#### Dude there is a front matter"

        front_matters = {} of String => String

        content.each_line do |line|

          content_array = line.split(":")

          if content_array.size >= 2
            # Parse ".. title: blah"
            key = content_array[0].gsub(/\.\. /, "").strip

            # @TODO: Here we should find the first : and split on it
            # Otherwise title like "hey dude: how are you" will not work
            value = content_array[1].strip

            front_matters[key] = value
          end

          # pp content_array

          if line.starts_with?("-->")
            pp "#### End of front matter"
            break
          end

          # pp line

        end

        pp front_matters
    end

  end

end
