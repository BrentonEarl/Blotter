class Pages < ActiveRecord::Base
  validates_presence_of :title, :body
  validates :title, length: { minimum: 3 }
  validates :body, length: { maximum: 200}
end
