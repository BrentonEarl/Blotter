class SiteSettings < ActiveRecord::Base
	validates_presence_of :name, :tagline, :author, :meta_description, :meta_keywords, :about_site
  validates :meta_description, length: { minimum: 1, maximum: 155 }
end
