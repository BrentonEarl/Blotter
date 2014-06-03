class CreateCategorizations < ActiveRecord::Migration
  def change
    create_table :categorizations do |t|
      t.column 'category_id', :integer
      t.column 'posts_id', :integer
     
      t.timestamps
    end
  end
end
