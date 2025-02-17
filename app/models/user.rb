class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  has_many :achievements
  has_many :activities
  has_one_attached :avatar

  validates :username, uniqueness: true, allow_blank: true
  validates :first_name, :last_name, presence: true, on: :update

  def name
    "#{first_name} #{last_name}".strip
  end

  attribute :languages, :string, default: '[]'
  attribute :canton, :string, default: 'Not specified'
  attribute :country_of_origin, :string, default: 'Not specified'

  before_save :ensure_languages_array

  def languages_list
    JSON.parse(languages || '[]').join(', ')
  end

  private

  def ensure_languages_array
    self.languages = '[]' if languages.blank?
  end
end
