class Post < BaseModel

  avram_enum Lang do
    Fr   # 0
    En  # 1
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
end
