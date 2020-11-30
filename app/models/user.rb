class User < ApplicationRecord
  has_many :articles, dependent: :destroy

  has_many :likes, dependent: :destroy
  has_many :liked_articles, through: :likes, source: :article

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def full_name
    if first_name? || last_name?
      "#{first_name.capitalize} #{last_name.capitalize}"
    else
      "User"
    end
  end

  def self.get_categories(user_id)
    Category.joins(:articles).group('categories.id').where(articles:{ user_id: user_id })
  end
  
end
