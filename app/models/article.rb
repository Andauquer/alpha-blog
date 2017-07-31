class Article < ActiveRecord::Base
  belongs_to :user
  #Con las siguiente dos lineas se crea la relacion de muchos a muchos, del lado de articles.
  has_many :article_categories
  has_many :categories, through: :article_categories
  validates :title, presence: true, length: { minimum: 3, maximum: 50 } 
  validates :description, presence: true, length: { minimum: 10, maximum: 300 } 
  validates :user_id, presence: true
end 