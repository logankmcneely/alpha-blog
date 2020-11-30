class Article < ApplicationRecord
  belongs_to :user

  has_many :article_categories
  has_many :categories, through: :article_categories

  has_many :likes
  has_many :liked_by, through: :likes, source: :user

  validates :title, presence: true, length: { minimum: 3, maximum: 72 }
  validates :description, presence: true

  has_rich_text :description

  # Returns false if article is not liked by user 'id', else returns the
  # id of the liked association in the database
  def liked_by_user?(id)
    query = self.likes.where(user_id: id).first
    return false unless query.present?
    query.id
  end

end
