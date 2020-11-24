class Article < ApplicationRecord
  belongs_to :user
  has_many :article_categories
  has_many :categories, through: :article_categories
  has_many :likes
  has_many :users, through: :likes
  validates :title, presence: true, length: { minimum: 4, maximum: 100 }
  validates :description, presence: true
  has_rich_text :description

  def liked_by_user?(id)
    query = self.likes.where(user_id: id).first
    return false unless query.present?
    query.id
  end
end
