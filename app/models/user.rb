class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  has_many :achievements
  has_many :activities

  validates :username, uniqueness: true, allow_blank: true
  validates :first_name, :last_name, presence: true, on: update

  def name
    "#{first_name} #{last_name}"
  end

  # Method to display languages as a string
  def languages_list
    languages.join(', ')
  end

  before_save :ensure_languages_array

  def languages_list
    JSON.parse(languages).join(', ')
  end

  private

  def ensure_languages_array
    self.languages = '[]' if languages.nil?
  end
end
