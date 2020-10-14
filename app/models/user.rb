class User < ApplicationRecord
  validates :username, 
    presence: true, 
    uniqueness: { case_sensitive: false }, 
    length: { minimum: 3, maximum: 25 }
  validates :email, 
    presence: true, 
    uniqueness: { case_sensitive: false }, 
    length: { maximum: 105 },
    format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i }
end
