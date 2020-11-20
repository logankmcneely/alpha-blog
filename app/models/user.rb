class User < ApplicationRecord
  before_save { self.email = email.downcase}
  has_many :articles, dependent: :destroy
  validates :username, 
    presence: true, 
    uniqueness: { case_sensitive: false }, 
    length: { minimum: 3, maximum: 25 }
  validates :email, 
    presence: true, 
    uniqueness: { case_sensitive: false }, 
    length: { maximum: 105 },
    format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i }
  has_secure_password

  def self.get_categories(user_id)
    Category.joins(:articles).group('categories.name').where(articles:{ user_id: user_id })
  end

end
