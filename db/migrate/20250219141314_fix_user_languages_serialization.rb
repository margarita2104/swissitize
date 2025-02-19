class FixUserLanguagesSerialization < ActiveRecord::Migration[7.0]
  def up
    User.find_each do |user|
      current_languages = user.languages
      if current_languages.is_a?(String)
        parsed_languages = JSON.parse(current_languages)
        user.update_column(:languages, parsed_languages.to_json)
      end
    rescue JSON::ParserError
      user.update_column(:languages, [].to_json)
    end
  end
end
