class CreateSiteSettings < ActiveRecord::Migration
  def change
      create_table :site_settings do |t| 
      t.string :name
      t.string :tagline
      t.string :author
      t.text  :meta_description
      t.text  :meta_keywords
      t.text  :about_site 

      t.timestamps
    end
  end
end