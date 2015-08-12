class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
    
      #t.timestamps, :null => true # doesn't work
      t.column  :created_at , :timestamp, :null => true
      t.column  :updated_at , :timestamp, :null => true
    end
  end
end
