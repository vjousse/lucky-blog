class Blog::IndexPage < GuestLayout
  def content

    article class: "flex flex-col justify-center tracking-tight text-justify leading-relaxed" do

      ul class: "text-xl" do

        li "Title 1" 
        li "Title 2" 
        li "Title 3"

      end

    end
  end
end
