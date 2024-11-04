class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  def name
    "#{first_name} #{last_name}"
  end
end
