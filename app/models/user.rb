class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  has_many :achievements
  has_many :activities
  has_one_attached :avatar

  validates :username, uniqueness: true, allow_blank: true
  validates :first_name, :last_name, presence: true, on: :update

  # Changed these language-related lines
  attribute :languages, :json, default: -> { [] }
  attribute :canton, :string, default: 'Not specified'
  attribute :country_of_origin, :string, default: 'Not specified'

  def name
    "#{first_name} #{last_name}".strip
  end

  def languages_list
    languages.join(', ')
  end

  def languages
    value = super
    return [] if value.nil?
    return value if value.is_a?(Array)

    begin
      parsed = JSON.parse(value)
      parsed.is_a?(Array) ? parsed : []
    rescue JSON::ParserError
      []
    end
  end
end
