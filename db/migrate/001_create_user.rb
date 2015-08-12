class CreateUser < ActiveRecord::Migration
  def change
    create_table :users do |t| 
      t.string :name
      t.string :email

      #t.timestamps, :null => true # doesn't work
      t.column  :created_at , :timestamp, :null => true
      t.column  :updated_at , :timestamp, :null => true
    end
  end
end