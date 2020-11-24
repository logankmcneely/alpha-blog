class User < ApplicationRecord
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
end
