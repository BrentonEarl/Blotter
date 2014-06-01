class Posts < ActiveRecord::Base
  validates :title, presence: true, length: { minimum: 3 }
  validates :author, presence: true, length: { minimum: 3 }
  validates :summary,  presence: true, length: { maximum: 200}
  validates :body, presence: true
end