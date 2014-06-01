class SiteSettings < ActiveRecord::Base
  validates :name, presence: true
  validates :tagline, presence: true
  validates :author,  presence: true
  validates :meta_description, presence: true, length: { minimum: 1, maximum: 155 }
  validates :meta_keywords, presence: true
  validates :about_site, presence: true  
end