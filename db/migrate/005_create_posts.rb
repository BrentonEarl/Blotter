class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t| 
      t.string :title
      t.string :author
      t.text   :summary
      t.text   :body

      #t.timestamps, :null => true # doesn't work
      t.column  :created_at , :timestamp, :null => true
      t.column  :updated_at , :timestamp, :null => true
    end
  end
end