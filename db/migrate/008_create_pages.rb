class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :title
      t.text	 :body
  		
      #t.timestamps, :null => true # doesn't work
      t.column  :created_at , :timestamp, :null => true
      t.column  :updated_at , :timestamp, :null => true
    end
  end
end
