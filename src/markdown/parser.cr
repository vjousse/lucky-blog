class Markdown::Parser
  def self.extract_front_matter(content : String)

    if content =~ /^<!--/
        pp "#### Dude there is a front matter"

        content.each_line do |line|

          if line =~ /^-->/
            pp "#### End of front matter"
            break
          end

          pp line

        end
    end

  end

end
