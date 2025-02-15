class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  has_many :achievements
  has_many :activities

  validates :first_name, :last_name, :username, presence: true
  validates :username, uniqueness: true

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
