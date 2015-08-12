class CreateCategorizations < ActiveRecord::Migration
  def change
    create_table :categorizations do |t|
      t.column 'category_id', :integer
      t.column 'posts_id', :integer
     
      #t.timestamps, :null => true # doesn't work
      t.column  :created_at , :timestamp, :null => true
      t.column  :updated_at , :timestamp, :null => true
    end
  end
end
