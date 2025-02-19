class ResetUserLanguages < ActiveRecord::Migration[7.0]
  def up
    User.update_all(languages: [])
  end
end
