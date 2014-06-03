class Posts < ActiveRecord::Base
  has_many :categorizations
  has_many :categories, :through => :categorizations
  
  validates_presence_of :title, :author, :summary, :body
  validates :title, length: { minimum: 3 }
  validates :author, length: { minimum: 3 }
  validates :summary, length: { maximum: 200}
end