class CreatePosts::V20200909163240 < Avram::Migrator::Migration::V1
  def migrate
    # Learn about migrations at: https://luckyframework.org/guides/database/migrations
    create table_for(Post) do
      primary_key id : Int64
      add_timestamps
      add title : String
      add content : String
      add published_at : Time
      add lang : Int32
    end
  end

  def rollback
    drop table_for(Post)
  end
end
