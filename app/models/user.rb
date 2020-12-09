class User < ApplicationRecord

  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable

  
  # <User>.articles returns all articles created by the user
  #   Ex: [<Article_id: __, title: __, created_at: __, ...>, ...]
  has_many :articles, dependent: :destroy

  # <User>.likes returns all like records associated with that user 
  #   Ex: [<Like_id: __, article_id: __, user_id: __>, ...]
  has_many :likes, dependent: :destroy

  # <User>.liked_articles returns all articles user has liked
  #   Ex: [<Article_id: __, title: __, created_at: __, ...>, ...]
  has_many :liked_articles, through: :likes, source: :article

  # <User>.article_messages returns all comment records associated with that user
  #   Ex: [<ArticleMessage_id: __, article_id: __, user_id: __, ...>, ...]
  has_many :article_messages, dependent: :destroy

  # <User>.commented_on returns all articles user has commented on
  #   Ex: [<Article_id: __, title: __, created_at: __, ...>, ...]
  has_many :commented_on, through: :article_messages, source: :article


  # Returns full name of <User> if available else a generic "User" is provided for name
  def full_name
    if first_name? || last_name?
      "#{first_name.capitalize} #{last_name.capitalize}"
    else
      "User"
    end
  end

  # Returns all categories <User> has created an article with
  def self.get_categories(user_id)
    Category.joins(:articles).group('categories.id').where(articles:{ user_id: user_id })
  end
  
end
