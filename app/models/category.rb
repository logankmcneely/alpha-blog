class Category < ApplicationRecord

  validates :name, 
    presence: true, 
    uniqueness: true,
    length: { minimum: 3, maximum: 20}


  # <Category>.article_categories returns the <ArticleCategory> of associated <Category>
  #   Ex: [<ArticleCategory_id: __, article_id: __, category_id: __>, ...]
  has_many :article_categories

  # <Category>.articles returns all <Article> associated with the <Category>
  #   Ex: [<Article_id: __, title: __, created_at: __, ...>, ...]
  has_many :articles, through: :article_categories
  
end
