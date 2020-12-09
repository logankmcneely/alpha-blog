class Article < ApplicationRecord

  validates :title, presence: true, length: { minimum: 3, maximum: 72 }
  validates :description, presence: true


  # <Article>.user returns the <User> of the article
  #   Ex: [<User_id: __, email: __, created_at: __, ...>]
  belongs_to :user

  # <Article>.article_categories returns all <ArticleCategory> associated with <Article>
  #   Ex: [<ArticleCategory_id: __, article_id: __, category_id: __>, ...]
  has_many :article_categories

  # <Article>.categories returns all <Category> associated with <Article>
  #   Ex: [<Category_id: __, name: __, created_at: __, ...>, ...]
  has_many :categories, through: :article_categories

  # <Article>.likes returns all <Like> associated with <Article>
  #   Ex: [<Like_id: __, article_id: __, user_id: __>, ...]
  has_many :likes

  # <Article>.liked_by returns all <User> who have liked <Article>
  #   Ex: [<User_id: __, email: __, created_at: __, ...>, ...]
  has_many :liked_by, through: :likes, source: :user

  # <Article>.article_messages returns all <ArticleMessage> associated with <Article>
  #   Ex: [<ArticleMessage_id: __, article_id: __, user_id: __, ...>, ...]
  has_many :article_messages

  # <Article>.comments_by returns all <User> who have commented on <Article>
  #   Ex: [<User_id: __, email: __, created_at: __, ...>, ...]
  has_many :comments_by, through: :article_messages, source: :user

  # <Article> includes ActionText with rich_text where the body of the article is saved
  has_rich_text :description


  # Determines if an <Article> is liked by a provided user.
  # If so, returns the <Like> id, else returns false
  def liked_by_user?(id)
    query = self.likes.where(user_id: id).first
    return false unless query.present?
    query.id
  end

end
