class Post < BaseModel
  table do
    column title : String
    column content : String
    column slug : String
    column filename : String
    column published_at : Time
    column lang : Int32
  end
end
